require 'test_helper'
require 'examples/car'

RSpec::Matchers.define :be_a_new_document do
  match do |document|
    document.new_document?
  end
end

describe Tyrion::Validations do
  subject{ Car.new }
  
  before(:each){ Car.reload }

  it 'should perform validations' do
    should_not be_valid
    subject.plate = 'AX567ED'
    should be_valid
  end
  
  it 'should say wether a document is new or not' do
    subject.plate = 'AX567ED'
    should be_a_new_document
    subject.save
    should_not be_a_new_document
  end
  
  it 'should not save an invalid document' do
    subject.save.should be_false
    Car.all.count.should be_zero
  end
end