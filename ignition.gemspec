spec = Gem::Specification.new do |s|
  s.name = 'ignition'
  s.summary = 'Static pages for Rails 3.'
  s.description = 'An engine for Rails 3 applications which allows easy management and caching of static pages.'
  s.version = '2.1.0'
  s.license = 'MIT'

  s.author = 'Graham Edgecombe'
  s.email = 'grahamedgecombe@gmail.com'
  s.homepage = 'http://grahamedgecombe.com/projects/ignition'

  s.platform = Gem::Platform::RUBY

  s.files = Dir['{app,config,lib}/**/*.rb']
  s.test_files = Dir['test/**/*.rb', 'test/dummy/config.ru']

  s.required_ruby_version = '>= 1.9.2'
  s.add_runtime_dependency 'rails', '~> 4.0'
end
