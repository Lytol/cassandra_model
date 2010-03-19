require 'test_helper'

class Post
  include CassandraModel::Resource
end

class ActiveModelLintTest < ActiveModel::TestCase
  include ActiveModel::Lint::Tests
 
  def setup
    @model = Post.new
  end
end
