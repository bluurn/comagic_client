require File.join(File.dirname(__FILE__), 'lib', 'comagic_client')

Gem::Specification.new do |s|
  s.name = 'comagic_client'
  s.version = ComagicClient::VERSION
  s.date = '2015-02-17'
  s.summary = 'Comagic API client'
  s.description = 'Comagic API client'
  s.authors = ['Vladimir Suvorov']
  s.email = 'bluurn@gmail.com'
  s.homepage = 'http://rubygems.org/gems/comagic_client'
  s.license = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rest-client"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
