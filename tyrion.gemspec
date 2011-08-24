# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tyrion/version"

Gem::Specification.new do |s|
  s.name        = "tyrion"
  s.version     = Tyrion::VERSION
  s.authors     = ["Federico Ravasio"]
  s.email       = ["ravasio.federico@gmail.com"]
  s.homepage    = "http://github.com/"
  s.summary     = %q{Tyrion is a small JSON ODM}
  s.description = %q{Tyrion's goal is to provide a fast (as in _easy to setup_) and dirty unstructured document store.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'multi_json'
  s.add_dependency 'json_pure'
  s.add_dependency 'active_support'
  
  s.add_development_dependency 'rspec'
end
