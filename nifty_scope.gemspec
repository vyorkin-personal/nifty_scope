# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nifty_scope/version'

Gem::Specification.new do |spec|
  spec.name          = "nifty_scope"
  spec.version       = NiftyScope::VERSION
  spec.authors       = ["Vasiliy Yorkin, Alexandr Shuhin"]
  spec.email         = ["vasiliy.yorkin@gmail.com"]
  spec.summary       = %q{ Provides an easy way to map request parameters to scopes }
  spec.description   = %q{ Provides an easy way to map request parameters to scopes }
  spec.homepage      = "http://github.com/vyorkin/nifty_scope"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord",  ">= 3.0.0"
  spec.add_runtime_dependency "activesupport", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "factory_girl_sequences"
  spec.add_development_dependency "database_cleaner"
end
