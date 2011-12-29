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

  it 'should say wether a document is new or not' do
    subject.plate = 'AX567ED'
    should_not be_persisted
    subject.save
    should be_persisted
  end

  it 'should not save an invalid document' do
    subject.save.should be_false
    Car.all.count.should be_zero
  end
end