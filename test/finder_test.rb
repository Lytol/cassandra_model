require 'test_helper'

class Post
  include CassandraModel::Resource
  
  key :title
  
  column :title
  column :body
end

class FinderTest < Test::Unit::TestCase
  
  context "get" do
    context "with unknown key" do
      setup do
        @post = Post.get("unknown key")
      end
      
      should "return nil" do
        assert_nil @post
      end
    end
    
    context "with known key" do
      setup do
        @post = Post.new(:title => "Test title", :body => "Test body")
        @post.save
        @post = Post.get("Test title")
      end
      
      should "return model" do
        assert @post.is_a?(Post)
      end
      
      should "not be new record" do
        assert !@post.new_record?
      end
    end
  end
end
