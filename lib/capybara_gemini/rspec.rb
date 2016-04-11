require 'capybara_gemini'
require 'capybara_gemini/rspec/matchers'

RSpec.configure do |config|
  config.include CapybaraGemini::RSpecMatchers, type: :feature
end
