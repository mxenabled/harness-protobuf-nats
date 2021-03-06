# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "harness/protobuf/nats/version"

Gem::Specification.new do |spec|
  spec.name          = "harness-protobuf-nats"
  spec.version       = Harness::Protobuf::Nats::VERSION
  spec.authors       = ["Garrett Thornburg"]
  spec.email         = ["film42@gmail.com"]

  spec.summary       = "a gem to collect instrumentation metrics from protobuf-nats"
  spec.description   = "a gem to collect instrumentation metrics from protobuf-nats"
  spec.homepage      = "https://github.com/mxenabled/harness-protobuf-nats"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.2"
  spec.add_runtime_dependency "harness", ">= 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
