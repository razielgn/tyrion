require 'test_helper'
require 'examples/post'

describe Tyrion::Document do
   
  let! :yml_posts do
    YAML.load_file File.join(File.dirname(__FILE__), 'fixtures', 'posts.yml')
  end
  
  before :each do
    delete_file
    Post.reload
    
    yml_posts.each do |p|
      a = Post.create! p
    end
    
    Post.reload
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
    context "when performing the search without a regexp" do
      it "should return a single value" do
        search = Post.find_by_title("Hello")
        search.should_not be_nil
        search.should_not be_a(Array)
      end
      
      it 'should return the first document found' do
        search = Post.find_by_rank(2)
        search.title.should == "Testing"
      end
      
      it "should return nil if nothing is found" do
        Post.find_by_title(5).should be_nil
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
  
  describe ".remove" do
    it "should remove all matching documents" do
      criteria = { :rank => 2, :body => /!$/ }
      Post.delete(criteria)
      Post.where(criteria).should be_empty
    end
  end
  
  describe ".where" do
    it 'should return an array on matching documents' do
      search = Post.where(:rank => 2, :body => /!$/)
      search.should_not be_nil
      search.should be_a(Array)
      search.count.should == 2
    end

    it 'shoudl return an empty array if no documents are matched' do
      Post.where(:title => /e/, :body => /^A/, :rank => 9000).should be_empty
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
  
  describe "#method_missing" do
    it 'should allow to read and update new attributes' do
      post = Post.new
      post.send :write_attribute, :comments, 1
      post.comments.should == 1
      post.comments = 2
      post.comments.should == 2
    end
  end
  
  describe "#delete" do
    it 'should remove the document' do
      Post.find_by_title("Hello").delete
      Post.find_by_title("Hello").should be_nil
    end
  end
end
