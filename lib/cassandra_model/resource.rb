module CassandraModel
  module Resource
    
    def self.included(base)
      base.extend ClassMethods
      base.extend CassandraModel::Finder
      
      base.class_eval <<-EOF
        extend ActiveModel::Naming
        include ActiveModel::Validations
        include ActiveModel::Conversion
        
        attr_reader :attributes, :errors
      EOF
    end
    
    def initialize(attrs = {})
      @errors = ActiveModel::Errors.new(self)
      @attributes = HashWithIndifferentAccess.new
      @new_record = false

      self.attributes = attrs
    end
    
    def new_record?() @new_record end
    def destroyed?()  true end # TODO

    def attributes=(attrs)
      attrs.each do |k,v|
        send("#{k}=", v)
      end
    end
    
    def save
      if valid?
        CassandraModel.client.insert(self.class.column_family, key, attributes)
        return true
      end
      return false
    end
    
    def key
      @key ||=  case self.class.key
                            when Symbol
                              send(self.class.key)
                            when Proc
                              self.class.key.call
                            else
                              Cassandra::UUID.new.to_guid
                            end
    end
    
    def key=(k)
      @key = k
    end
    
    def new_record=(bool)
      @new_record = bool
    end
  end
  
  module ClassMethods
    
    def column(name)
      self.columns << name.to_s
      class_eval <<-EOF
        define_method :#{name.to_s} do
          @attributes[:#{name.to_s}]
        end
        
        define_method :#{name.to_s}= do |val|
          @attributes[:#{name.to_s}] = val
        end
      EOF
    end
    
    def columns
      @columns ||= []
    end
    
    def column_family
      to_s.to_sym
    end
    
    def key(symbol_or_proc = nil, &block)
      if symbol_or_proc
        @key_method = symbol_or_proc
      elsif block_given?
        @key_method = block
      else
        @key_method
      end
    end    
  end
end
