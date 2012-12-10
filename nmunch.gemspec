# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nmunch/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michael Henriksen"]
  gem.email         = ["michenriksen87@gmail.com"]
  gem.description   = %q{Nmunch is a passive network discovery tool that finds live network nodes by analyzing ARP and broadcast packets.}
  gem.summary       = %q{OM NOM NOM NOM}
  gem.homepage      = "https://github.com/michenriksen/nmunch"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nmunch"
  gem.require_paths = ["lib"]
  gem.version       = Nmunch::VERSION
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rake', '>= 0.9.2')
  gem.add_dependency('methadone', '~> 1.2.3')
  gem.add_dependency('pcap', '~> 0.7.7')
  gem.add_dependency('paint')
end
