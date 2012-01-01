require 'test_helper'
require 'examples/car'

describe Tyrion::Validations do
  subject{ Car.new }

  before(:each){ Car.reload }

  it 'should perform validations' do
    should_not be_valid
    subject.plate = 'AX567ED'
    should be_valid
  end

  it 'should perform complex validations' do
    subject.plate = 'A'
    should_not be_valid
    subject.plate = 'AA000AA'
    should be_valid
  end

  it 'should not save an invalid document' do
    count = Car.count
    subject.save.should be_false
    Car.count.should == count
  end
end
