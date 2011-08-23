require 'mocha'
require 'tmpdir'
require 'fileutils'

require 'tyrion'
Tyrion::Connection.path = Dir.tmpdir

RSpec.configure{ |config| config.mock_with :mocha }

def delete_file
  file = File.join(Dir.tmpdir, 'post.json')
  FileUtils.rm file if File.exists?(file)
end
