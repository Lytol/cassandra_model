require 'active_model'
require 'active_support'
require 'cassandra'

require 'active_support/core_ext/hash/indifferent_access'

module CassandraModel
  extend self

  VERSION = "0.1.0"

  DEFAULT_CONFIG = {
    :keyspace       => nil,
    :hosts          => '127.0.0.1:9160',
    :thrift_options => {}
  }
  
  class ConfigurationError < StandardError; end

  attr_reader :client


  def config(attrs = {})
    configuration.merge!(attrs)
    yield self if block_given?
    return configuration
  end
  
  ["keyspace", "hosts", "thrift_options"].each do |c|
    define_method("#{c}=".to_sym) do |val|
      configuration[c] = val
    end
  end

  def client
    raise(ConfigurationError, "requires a keyspace") if configuration[:keyspace].nil?
    @client ||= Cassandra.new(configuration[:keyspace], configuration[:hosts], configuration[:thrift_options])
  end

  private

    def configuration
      @configuration ||= HashWithIndifferentAccess.new(DEFAULT_CONFIG)
    end

end

require 'cassandra_model/resource'
require 'cassandra_model/finder'
