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
