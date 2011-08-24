require 'bundler'
Bundler::GemHelper.install_tasks

require 'yard'

desc 'Generate documentation'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', '-', 'LICENSE']
  t.options = ['--main', 'README.markdown', '--no-private']
end