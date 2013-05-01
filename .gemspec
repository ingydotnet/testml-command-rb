# encoding: utf-8

GemSpec = Gem::Specification.new do |gem|
  gem.name = 'testml-command'
  gem.version = '0.0.1'
  gem.license = 'MIT'
  gem.required_ruby_version = '>= 1.9.1'

  gem.authors << 'Ingy döt Net'
  gem.email = 'ingy@ingy.net'
  gem.summary = 'TestML Language Interpreter Command'
  gem.description = <<-'.'
Run TestML as a general purpose programming language.
.
  gem.homepage = 'http://testml.org'

  gem.files = `git ls-files`.lines.map{|l|l.chomp}

  gem.add_dependency 'testml', '>= 0.0.2'
end
