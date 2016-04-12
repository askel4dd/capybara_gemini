module CapybaraGemini
  class Comparator
    attr_reader :error, :difference

    def initialize(reference_screenshot, current_screenshot)
      @reference_screenshot = reference_screenshot
      @current_screenshot = current_screenshot
      validate!
    end

    def compare
      if need_to_compare?
        reference_file.height.times do |y_axis|
          reference_file.row(y_axis).each_with_index do |pixel, x_axis|
            if file_to_compare[x_axis, y_axis] != pixel
              file_to_compare[x_axis, y_axis] = Screenshot::DIFFERENCE_COLOR
            end
          end
        end

        file_to_compare.save(File.join(@current_screenshot.dirname, 'difference.png'))
      end
      self
    end

    def valid?
      !@error
    end

    private

    def reference_file
      @reference_screenshot.file
    end

    def file_to_compare
      @current_screenshot.file
    end

    def need_to_compare?
      reference_file && file_to_compare && reference_size == current_size
    end

    def reference_size
      [reference_file.width, reference_file.height]
    end

    def current_size
      [file_to_compare.width, file_to_compare.height]
    end

    def validate!
      @error =
        if !reference_file
          :missing_reference
        elsif !file_to_compare
          :missing_current
        elsif reference_size != current_size
          :different_size
        elsif reference_file != file_to_compare
          :different
        end
    end
  end
end
