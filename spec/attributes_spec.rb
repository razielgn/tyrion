require 'test_helper'
require 'examples/post'

describe Tyrion::Attributes do
  describe '.new' do
    it 'should create a new instance with given attributes' do
      post = Post.new :title => 'Title', :body => 'Body'
      post.title.should == 'Title'
      post.body.should == 'Body'
    end
  end

  describe '==' do
    it 'should return true if two documents are equal' do
      post1 = Post.new(:title => 'Title', :rank => 3)
      post2 = Post.new(:title => 'Title', :rank => 3)
      post1.should == post2
    end

    it 'should return false otherwise' do
      post1 = Post.new(:title => 'Title', :rank => 3)
      post2 = Post.new(:title => 'Title', :rank => 999)
      post1.should_not == post2
    end
  end

  describe '#method_missing' do
    it 'should allow to read and update new attributes' do
      post = Post.new
      post.send :write_attribute, :comments, 1
      post.comments.should == 1
      post.comments = 2
      post.comments.should == 2
    end
  end
end
