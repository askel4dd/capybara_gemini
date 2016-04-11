lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = 'capybara_gemini'
  s.version = '0.0.0'
  s.required_ruby_version = '>= 2.3.0'
  s.license = 'MIT'

  s.authors = ['Savin Dmitriy']
  s.email = 'dsa@jetthoughts.com'
  s.description = 'Capybara Gemini is a tool for testing css regressions.'

  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.md)

  s.homepage = 'https://github.com/askel4dd/capybara_gemini'
  s.require_paths = ['lib']
  s.summary = 'Simplify css regressions testing.'

  s.add_runtime_dependency('chunky_png')
  s.add_runtime_dependency('capybara')

  s.add_development_dependency('selenium-webdriver', ['~> 2.0'])
  s.add_development_dependency('sinatra', ['>= 0.9.4'])
  s.add_development_dependency('rspec', ['>= 2.2.0'])
  s.add_development_dependency('launchy', ['>= 2.0.4'])
  s.add_development_dependency('rake')
end
