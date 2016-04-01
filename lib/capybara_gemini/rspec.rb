require 'capybara_gemini'

RSpec.configure do |config|
  config.include CapybaraGemini::DSL, type: :regression
end
