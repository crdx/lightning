require_relative 'lib/lightning/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/lightning'
    spec.summary  = 'Lightning web framework'
    spec.name     = 'lightning-framework'
    spec.version  = Lightning::VERSION
    spec.author   = 'crdx'
    spec.license  = 'GPLv3'

    spec.files = Dir['{lib}/**/*']

    spec.add_runtime_dependency "sinatra",         "~> 3.0"
    spec.add_runtime_dependency "sinatra-contrib", "~> 3.0"
    spec.add_runtime_dependency "erubis",          "~> 2.7"
    spec.add_runtime_dependency "activerecord",    "~> 7.0"
    spec.add_runtime_dependency "mysql2",          "~> 0.5.2"

    spec.add_runtime_dependency "rack",            "~> 2.0"
    spec.add_runtime_dependency "rack-test",       "~> 1.1"
    spec.add_runtime_dependency "rack-protection", "~> 3.0"
    spec.add_runtime_dependency "rake",            "~> 13.0"
    spec.add_runtime_dependency "rspec",           "~> 3.8"

    spec.add_runtime_dependency "colorize",        "~> 0.8.1"
    spec.add_runtime_dependency "dotenv",          "~> 2.7"
end
