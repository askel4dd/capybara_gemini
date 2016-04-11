module CapybaraGemini
  class ReferenceScreenshot < Screenshot

    attr_reader :path

    def initialize(name, page)
      @path = screenshot_path(name)
      @page = page
    end

    def fetch
      if !File.exist?(path) || CapybaraGemini.update?
        @page.driver.save_screenshot(path, full: true)
      end
      ChunkyPNG::Image.from_file path
    end

    private

    def screenshot_path(file_name)
      File.join(Rails.root.join('spec/fixtures/screenshots/'), file_name + '.png')
    end
  end
end
