require 'tmpdir'
require 'fileutils'

require 'tyrion'
Tyrion::Connection.path = Dir.tmpdir

def delete_file
  file = File.join(Dir.tmpdir, 'post.json')
  FileUtils.rm file if File.exists?(file)
end
