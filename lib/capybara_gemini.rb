require 'capybara_gemini/comparator'
require 'capybara_gemini/current_screenshot'
require 'capybara_gemini/reference_screenshot'

module CapybaraGemini
  class << self
    def configure
      yield self
    end

    def action=(action)
      @action ||= action
    end

    def action
      @action || ENV['CAPYBARA_GEMINI_ACTION'] || 'test'
    end

    def update?
      action == 'update'
    end
  end
end
