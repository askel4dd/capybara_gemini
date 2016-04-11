module CapybaraGemini
  class CurrentScreenshot < Screenshot
    SCREENSHOTS_PATH = Capybara.save_and_open_page_path

    attr_reader :path, :file

    def initialize(name, page)
      @path = screenshot_path(name)
      @page = page
    end

    def create
      @page.driver.save_screenshot(path.to_s, full: true)
      @file = ChunkyPNG::Image.from_file path
    end

    private

    def screenshot_path(file_name)
      path = File.join(Dir.tmpdir, file_name)
      FileUtils.mkdir_p(path)
      path + 'current.png'
    end
  end
end
