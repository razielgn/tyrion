require 'tmpdir'
require 'fileutils'

require 'tyrion'

tmpdir = Dir.mktmpdir
Tyrion::Connection.path = tmpdir

RSpec.configure do |config|
  config.before(:each) do
    Tyrion::Connection.path = Dir.mktmpdir
  end
  
  config.after(:each) do
    FileUtils.rm_rf Tyrion::Connection.path
  end
  
  config.after(:suite) do
    FileUtils.rm_rf tmpdir
  end
end