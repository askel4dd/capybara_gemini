module CapybaraGemini
  autoload :Comparator, 'capybara_gemini/comparator'
  autoload :Screenshot, 'capybara_gemini/screenshot'
  autoload :ReferenceScreenshot, 'capybara_gemini/reference_screenshot'
  autoload :CurrentScreenshot, 'capybara_gemini/current_screenshot'

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
