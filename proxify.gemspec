# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proxify/version'

Gem::Specification.new do |gem|
  gem.name          = "proxify"
  gem.version       = Proxify::VERSION
  gem.authors       = ["Robbie Clutton"]
  gem.email         = ["hello@iclutton.com"]
  gem.description   = %q{Create a proxy for any object.}
  gem.summary       = %q{Create a proxy for any object.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
