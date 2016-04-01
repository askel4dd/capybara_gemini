module CapybaraGemini
  class ReferenceScreenshot < Screenshot
    SCREENSHOTS_PATH = Rails.root.join('spec/fixtures/screenshots/')

    attr_reader :path

    def initialize(name, page)
      @path = Pathname.new(SCREENSHOTS_PATH + name)
      @page = page
    end

    def fetch
      if CapybaraGemini.update?
        @page.save_screenshot(path, full: true)
      end
      ChunkyPNG::Image.from_file path
    end
  end
end
