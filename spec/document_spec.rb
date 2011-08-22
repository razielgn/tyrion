require 'test_helper'
require 'examples/post'

describe Tyrion::Document do
  let! :yml_posts do
    YAML.load_file File.join(File.dirname(__FILE__), 'fixtures', 'posts.yml')
  end
  
  before :each do
    yml_posts.each do |p|
      a = Post.create! p
    end
  end
  
  describe ".create" do
    post = Post.create :title => "Title", :body => "Body"
    post.title.should == "Title"
    post.body.should == "Body"
  end
  
  describe ".all" do
    it 'should find three posts' do
      Post.all.count.should == 3
    end
  end
  
  describe ".find_by_" do
    context "when performing the search with a string" do
      it "should return a single value" do
        search = Post.find_by_title("Hello")
        search.should_not be_nil
        search.should_not be_a(Array)
      end
      
      it "should return nil if nothing is found" do
        Post.find_by_title("A").should be_nil
      end
    end
    
    context "when performing the search with a regexp" do
      it "should return a single value" do
        search = Post.find_by_title(/Hello/).should_not be_nil
        search.should_not be_nil
        search.should_not be_a(Array)
      end
      
      it "should return nil if nothing is found" do
        Post.find_by_title(/^u/).should be_nil
      end
    end
    
    it 'should raise an exception if the search is performed without arguments' do
      expect do
        Post.find_by_body
      end.to raise_exception
    end
    
    it 'should raise an exception if the search is performed on an unknown attribute' do
      expect do
        Post.find_by_id
      end.to raise_exception
    end
  end
  
  describe ".remove_all" do
    it 'should delete every document' do
      Post.delete_all
      Post.all.count.should == 0
    end
  end
  
  describe "#save" do
    it 'should save a new document' do
      post = Post.new
      post.title = "Title"
      post.body = "Body"
      post.save.should be_true
    end
  end
  
  describe "#delete" do
    it 'should remove the document' do
      Post.find_by_title("Hello").delete
      Post.find_by_title("Hello").should be_nil
    end
  end
end
