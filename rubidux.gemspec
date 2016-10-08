# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubidux/version'

Gem::Specification.new do |spec|
  spec.name          = "rubidux"
  spec.version       = Rubidux::VERSION
  spec.authors       = ["Juin Chiu"]
  spec.email         = ["davidjuin0519@gmail.com"]

  spec.summary       = "A tiny ruby framework inspired by Redux"
  spec.description   = "A tiny ruby framework inspired by Redux"
  spec.homepage      = "https://github.com/davidjuin0519/rubidux"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
