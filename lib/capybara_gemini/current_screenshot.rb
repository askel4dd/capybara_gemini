module CapybaraGemini
  class CurrentScreenshot < Screenshot

    attr_reader :dirname, :file

    def initialize(name, page)
      @absolute_path = screenshot_absolute_path(name)
      @dirname = File.dirname(@absolute_path)
      @page = page
    end

    def create
      @page.driver.save_screenshot(@absolute_path, full: true)
      @file = ChunkyPNG::Image.from_file(@absolute_path)
      self
    end

    private

    def screenshot_absolute_path(file_name)
      path = File.join(Dir.tmpdir, file_name)
      FileUtils.mkdir_p(path)
      path + 'current.png'
    end
  end
end
