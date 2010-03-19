require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'active_model'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'cassandra_model'

class Test::Unit::TestCase
  
  def setup
    CassandraModel.config do |c|
      c.keyspace  = "CassandraModelTest"
      c.hosts     = "127.0.0.1:9160"
    end
  end
end
