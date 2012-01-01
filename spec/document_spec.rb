require 'test_helper'
require 'examples/post'

describe Tyrion::Document do
  subject{ Post }

  its(:klass_name){ should == 'post' }
end
