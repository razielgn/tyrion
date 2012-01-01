require 'test_helper'
require 'examples/post'

describe Tyrion::Persistence do
  before(:each) do
    Tyrion::Connection.path = Dir.mktmpdir
    Post.reload
  end

  after(:each) do
    FileUtils.rm_rf Tyrion::Connection.path
  end

  describe '.create' do
    it 'should save a new instance with given attributes' do
      post = Post.create :title => 'Title', :body => 'Body'
      post.title.should == 'Title'
      post.body.should == 'Body'
      post.should be_persisted
    end
  end

  describe '.remove_all' do
    it 'should delete every document' do
      5.times{ Post.create :title => 'Title', :body => 'Body' }
      Post.delete_all
      Post.reload
      Post.count.should == 0
    end
  end

  describe '#save' do
    it 'should save a new document' do
      post = Post.new
      post.should_not be_persisted
      post.title = 'Title'
      post.body = 'Body'
      post.save.should be_true
      post.should be_persisted
    end
  end

  describe '#delete' do
    it 'should remove the document' do
      count = Post.count
      post = Post.create :title => 'Title2', :body => 'Body2'
      post.delete
      Post.count.should == count
    end
  end

  it 'should persist data across reloads' do
    post = Post.create :title => 'Title', :body => 'Body'
    Post.reload
    Post.last.should == post
  end
end
