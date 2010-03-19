$:.unshift(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'cassandra_model'


class User
  include CassandraModel::Resource
  
  column :email
  column :name
end


CassandraModel.config(:keyspace => "MyApp", :hosts => "127.0.0.1:9160")

puts "Creating and saving user:"
user = User.new(:name => "John Smith", :email => "jsmith@domain.com")
user.save
puts "=> Key: #{user.key} / #{user.name} / #{user.email}\n\n"

puts "Fetching user:"
puts "=> #{User.get(user.key).inspect}\n\n"
