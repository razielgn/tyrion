require 'tyrion'

tmp_dir = File.join(File.dirname(__FILE__), '..', 'tmp')
FileUtils.mkdir tmp_dir unless File.directory? tmp_dir
Tyrion::Connection.path = tmp_dir

require 'mocha'

RSpec.configure{ |config| config.mock_with :mocha }
