require 'test_helper'

class Post
  include CassandraModel::Resource
  
  key :title
  
  column :title
  column :body
end

class Comment
  include CassandraModel::Resource
  
  column :message
  column :user_id
end

class ResourceTest < Test::Unit::TestCase
    
  should "have columns" do
    assert Post.columns.include?('title')
    assert Post.columns.include?('body')
  end
  
  should "have column_family from class name" do
    assert_equal :Post, Post.column_family
  end

  context "new" do
    setup do
      @post = Post.new(:title => "Test title")
    end
    
    should "generate key" do
      assert_equal "Test title", @post.key
    end
    
    context "without attributes" do
      setup { @post = Post.new }
      
      should "have nil attributes" do
        assert_nil @post.title
        assert_nil @post.body
      end
    end
    
    context "with attributes" do
      setup { @post = Post.new(:title => "Title", :body => "Body") }
      
      should "have set attributes" do
        assert_equal "Title", @post.title
        assert_equal "Body", @post.body
      end
    end
    
    context "with invalid attribute" do
      should "raise NoMethodError" do
        assert_raises NoMethodError do
          Post.new(:bogus => "blah")
        end
      end
    end
  end
  
  context "save" do    
    context "when new record" do
      context "with valid attributes" do
        setup do
          @post = Post.new(:title => "Test title", :body => "Test body")
        end
      
        should "return true" do
          assert @post.save
        end
      end
    end
  end
  
end
