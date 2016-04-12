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
      @_action ||= action
    end

    def action
      @_action || ENV['CAPYBARA_GEMINI_ACTION'] || 'test'
    end

    def reference_screenshots_path=(path)
      @_reference_screenshots_path ||= path
    end

    def reference_screenshots_path
      @_reference_screenshots_path
    end

    def update?
      action == 'update'
    end
  end
end
