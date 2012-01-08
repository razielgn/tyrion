require 'test_helper'
require 'examples/post'

describe Tyrion::Querying do
  subject{ Post }

  before(:all) do
    Tyrion::Connection.path = Dir.mktmpdir

    @test_docs = [
      { :title => 'Title', :rank => 10, :body => 'Lorem ipsum dolor sit amet'},
      { :title => 'Titlf', :rank => 2,  :body => 'Consectetur adipisicing elit'},
      { :title => 'Titmf', :rank => 4,  :body => 'Sed do eiusmod tempor'},
      { :title => 'Tiumf', :rank => 5,  :body => 'Incididunt ut labore et dolore'},
      { :title => 'Tjumf', :rank => 5,  :body => 'Magna aliqua ut enim ad minim'},
      { :title => 'Ujumf', :rank => 5,  :body => 'Quis nostru exercitation ullamco'},
      { :title => 'Ujumg', :rank => 4,  :body => 'Duis aute irure dolor in'}
    ]

    @test_docs.each do |post|
      Post.create(post)
    end
  end

  after(:all) do
    Post.delete_all
  end

  describe '.all' do
    it 'should return a criteria when calling its methods' do
      Post.all.should be_a(Tyrion::Criteria)
    end

    it 'should create a Criteria instance and passing the model\'s class name' do
      Post.all.klass.should == Post.send(:klass_name)
    end

    it 'should return an enumerable' do
      Post.all.class.ancestors.should include(Enumerable)
    end

    it 'should return an iterable collection of Tyrion::Documents' do
      Post.all.each do |doc|
        doc.should be_a(Tyrion::Document)
      end
    end
  end

  describe '.where' do
    it 'should filter documents' do
      Post.where(:title => 'Title').to_a.should == [Post.new(@test_docs[0])]
      Post.where(:rank => 5).to_a.should == [Post.new(@test_docs[3]),
                                             Post.new(@test_docs[4]),
                                             Post.new(@test_docs[5])]
      Post.where(:foo => 'bar').count.should be_zero
    end
  end

  its(:first){ should == Post.new(@test_docs.first) }
  its(:last){ should == Post.new(@test_docs.last) }
  its(:count){ should == @test_docs.count }

  describe '.limit' do
    it 'should limit returned documents' do
      Post.limit(2).count.should == 2
      Post.limit(2).to_a.should == [Post.new(@test_docs[0]),
                                    Post.new(@test_docs[1])]
    end

    it 'should be chainable' do
      Post.where(:rank => 5).limit(2).to_a.should == [Post.new(@test_docs[3]),
                                                      Post.new(@test_docs[4])]
    end

    it 'should not limit if the parameter is greater than the overall count' do
      Post.limit(Post.count + 10).count.should == Post.count
    end
  end

  describe '.skip' do
    it 'should skip documents' do
      Post.skip(5).to_a.should == [Post.new(@test_docs[5]),
                                   Post.new(@test_docs[6])]
    end

    it 'should return an empty array if all the documents are skipped' do
      Post.skip(10).to_a.should be_empty
    end
  end

  describe '.asc' do
    it 'should sort ascendingly returned documents' do
      Post.asc(:rank).to_a.should == @test_docs.sort_by{|d| d[:rank]}.map{|d| Post.new(d)}
      Post.asc(:rank, :title).to_a.should == @test_docs.sort_by{|d| [d[:rank], d[:title]]}.map{|d| Post.new(d)}
    end
  end

  describe '.desc' do
    it 'should sort descendingly returned documents' do
      Post.desc(:rank).to_a.should == @test_docs.sort_by{|d| d[:rank]}.map{|d| Post.new(d)}.reverse
      Post.desc(:rank, :title).to_a.should == @test_docs.sort_by{|d| [d[:rank], d[:title]]}.map{|d| Post.new(d)}.reverse
    end
  end

  describe 'chains' do
    it 'should perform complex(?) chains' do
      Post.where(:rank => 5).skip(1).limit(2).desc(:body).to_a.should == [Post.new(@test_docs[5]),
                                                                          Post.new(@test_docs[4])]

      Post.where(:rank => 4).desc(:body).first.should == Post.new(@test_docs[2])
      Post.where(:title => 1).desc(:rank).to_a.should be_empty
      Post.where(:rank => 10).skip(1).to_a.should be_empty
    end
  end
end
