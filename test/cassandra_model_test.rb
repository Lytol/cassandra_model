require 'test_helper'

class CassandraModelTest < Test::Unit::TestCase

  should "have version with major, minor and patch" do
    assert CassandraModel::VERSION =~ /^\d+\.\d+\.\d+$/
  end
  
  context "config" do
    context "with block" do
      setup do
        CassandraModel.config do |c|
          c.keyspace = "Test"
          c.hosts = "other:9160"
        end
      end
      
      should "set Keyspace" do
        assert_equal "Test", CassandraModel.config[:keyspace]
      end
      
      should "set hosts" do
        assert_equal "other:9160", CassandraModel.config[:hosts]
      end
    end
    
    context "with attrs" do
      setup do
        CassandraModel.config(:keyspace => "Test", :hosts => "other:9160")
      end
      
      should "set Keyspace" do
        assert_equal "Test", CassandraModel.config[:keyspace]
      end
      
      should "set hosts" do
        assert_equal "other:9160", CassandraModel.config[:hosts]
      end
    end
    
    context "without block or attrs" do
      should "return hash" do
        config = CassandraModel.config
        assert config.has_key?(:keyspace)
        assert config.has_key?(:hosts)
        assert config.has_key?(:thrift_options)
      end
    end
  end
end
