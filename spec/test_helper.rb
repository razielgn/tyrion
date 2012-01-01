require 'simplecov'
SimpleCov.start

require 'tmpdir'
require 'fileutils'

require 'tyrion'

tmpdir = Dir.mktmpdir
Tyrion::Connection.path = tmpdir

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf tmpdir
  end
end

def add_connection_cleanup!
  RSpec.configure do |config|
    config.before(:each) do
      Tyrion::Connection.path = Dir.mktmpdir
    end

    config.after(:each) do
      FileUtils.rm_rf Tyrion::Connection.path
    end
  end
end
