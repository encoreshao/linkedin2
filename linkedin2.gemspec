# encoding: utf-8
require File.expand_path('../lib/linked_in2/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'hashie', ['>= 1.2', '< 2.1']
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency "oauth2", "~> 0.5.1"
  gem.add_development_dependency 'json', '~> 1.6'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rdoc', '~> 3.8'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'simplecov', '~> 0.5'
  gem.add_development_dependency 'vcr', '~> 1.10'
  gem.add_development_dependency 'webmock', '~> 1.9'
  
  gem.authors = ["Encore Shao"]
  gem.description = %q{A Ruby wrapper for Linkedin API(OAuth2)}
  gem.email = ['encore.shao@gmail.com']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'http://github.com/encore.shao/linkedin2'
  gem.name = 'linkedin2'

  gem.require_paths = ['lib']
  gem.summary = gem.description
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = LinkedIn2::VERSION::STRING
end
