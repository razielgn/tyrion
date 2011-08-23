require 'test_helper'

describe Tyrion::Connection do
  before{ @original_path = subject.path }  
  after{ subject.path = @original_path }
  
  describe '.path' do
    it 'should raise an exception if no path is set' do
      expect do
        subject.path = nil
        subject.path
      end.to raise_exception
    end
  end
  
  describe '.path=' do
    it 'should set the path correctly' do
      subject.path = ENV['HOME']
      subject.path.should == ENV['HOME']
    end
  end
end
