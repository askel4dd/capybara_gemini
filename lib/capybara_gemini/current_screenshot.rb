module CapybaraGemini
  class CurrentScreenshot < Screenshot
    SCREENSHOTS_PATH = Rails.root

    attr_reader :path

    def initialize(name, page)
      @path = Pathname.new(SCREENSHOTS_PATH + name)
      @page = page
    end

    def create
      @page.save_screenshot(path, full: true)
      ChunkyPNG::Image.from_file path
    end
  end
end
