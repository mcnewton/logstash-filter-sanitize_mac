Gem::Specification.new do |s|
  s.name          = 'logstash-filter-sanitize_mac'
  s.version       = '0.1.0'
  s.licenses      = ['Apache License (2.0)']
  s.summary       = 'Logstash filter plugin to sanitize network MAC addresss'
  s.description   = 'MAC addresses can come in many different forms. This filter attempts to standardise them to make elasticsearch logs easier to search.'
  s.homepage      = 'https://github.com/mcnewton/logstash-filter-sanitize_mac'
  s.authors       = ['Matthew Newton']
  s.email         = 'matthew-git@newtoncomputing.co.uk'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_development_dependency 'logstash-devutils'
end
