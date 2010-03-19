module CassandraModel
  module Finder
    
    def get(key)
      attrs = CassandraModel.client.get(self.column_family, key)
      
      if attrs.present?
        obj = new(attrs)
        obj.key = key
        obj.new_record = false
        obj
      else
        nil
      end
    end
  end
end