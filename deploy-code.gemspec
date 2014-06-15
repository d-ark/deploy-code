# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deploy/code/version'

Gem::Specification.new do |spec|
  spec.name          = "deploy-code"
  spec.version       = Deploy::Code::VERSION
  spec.authors       = ["Alexey Fedorov"]
  spec.email         = ["waterlink000@gmail.com"]
  spec.summary       = %q{Used to deploy your apps from git easily. Highly customizable.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/waterlink/deploy-code"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "capistrano", "= 2.15.5"
end
