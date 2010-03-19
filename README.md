CassandraModel
==============

Persist your objects to Cassandra -- conforms to ActiveModel API


Getting Started
---------------

**Note:** If you haven't already, make sure you have Cassandra configured and running. Here are a few resources to get you started:

  * [Cassandra Apache Project](http://cassandra.apache.org/)
  * [Cassandra Wiki](http://wiki.apache.org/cassandra/FrontPage)
  * [Evan Weaver's "Up and Running with Cassandra"](http://blog.evanweaver.com/articles/2009/07/06/up-and-running-with-cassandra/)
  * There is a sample <code>storage-conf.xml</code> for this example at **example/storage-conf.xml**.

### Configuration ###

You must configure CassandraModel with your keyspace and hosts:

    CassandraModel.config(:keyspace => "MyApp", :hosts => "127.0.0.1:9160")

### Define a Model ###

    class User
      include CassandraModel::Resource
      
      column :email
      column :name
    end


### Creating ###

    @user = User.new(:email => 'bsmith@swig505.com', :name => "Brian Smith")
    @user.save
    puts "Key: #{@user.key}"  # Note that a key will be auto-generated (GUID) if none is given


### Fetching ###

    @user = User.get("11cb871a-338b-11df-9f62-ef46bcab0d62")
    puts "#{@user.email} / #{@user.name}"


Copyright
---------

Copyright (c) 2010 Brian Smith. See LICENSE for details.
