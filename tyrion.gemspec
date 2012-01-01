# encoding: utf-8

$:.push File.expand_path('../lib', __FILE__)
require 'tyrion/version'

Gem::Specification.new do |s|
  s.name        = 'tyrion'
  s.version     = Tyrion::VERSION
  s.authors     = ['Federico Ravasio']
  s.email       = ['ravasio.federico@gmail.com']
  s.homepage    = 'http://github.com/razielgn/tyrion'
  s.summary     = 'Tyrion is a small JSON ODM'
  s.description = 'Tyrion\'s goal is to provide a fast (as in _easy to setup_) and dirty unstructured document store.'

  s.files         = Dir.glob('lib/**/*') + %w(LICENSE README.markdown Rakefile)
  s.require_path  = 'lib'

  s.add_dependency 'multi_json'
  s.add_dependency 'json_pure'
  s.add_dependency 'activemodel', '~> 3.1.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'simplecov'
end
