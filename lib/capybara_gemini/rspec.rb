require 'capybara_gemini'
require 'capybara_gemini/dsl'
require 'rspec/core'

RSpec.configure do |config|
  config.include CapybaraGemini::DSL, type: :regression
end
