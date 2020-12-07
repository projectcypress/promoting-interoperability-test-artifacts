Gem::Specification.new do |s|
  s.name = "promoting-interoperability-test-artifacts"
  s.summary = "A library for export of test data for g1/g2 certification criteria."
  s.description = "A library for export of test data for g1/g2 certification criteria."
  s.email = "tacoma-list@lists.mitre.org"
  s.homepage = "https://github.com/projectcypress/g1g2-exports"
  s.authors = ["The MITRE Corporation"]
  s.license = 'Apache-2.0'

  s.version = '0.0.1'

  s.add_dependency 'mustache'

  s.add_dependency 'erubis', '~> 2.7'

  s.add_dependency 'nokogiri', '~> 1.10'
  s.add_dependency 'uuid', '~> 2.3'

  s.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.json') + Dir.glob('lib/**/*.mustache') + Dir.glob('lib/**/*.rake') + ["Gemfile", "README.md", "Rakefile"]
end
