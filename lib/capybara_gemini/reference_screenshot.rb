module CapybaraGemini
  class ReferenceScreenshot < Screenshot

    attr_reader :absolute_path, :file

    def initialize(name, page)
      @absolute_path = absolute_screenshot_path(name)
      @page = page
    end

    def fetch
      if !File.exist?(@absolute_path) || CapybaraGemini.update?
        @page.driver.save_screenshot(@absolute_path, full: true)
      end
      @file = ChunkyPNG::Image.from_file(@absolute_path)
      self
    end

    private

    def absolute_screenshot_path(file_name)
      File.join(CapybaraGemini.reference_screenshots_path, file_name + '.png')
    end
  end
end
