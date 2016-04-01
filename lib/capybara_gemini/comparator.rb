module CapybaraGemini
  class Comparator
    attr_reader :error, :difference

    def initialize(original_file, file_to_compare)
      @original_file = original_file
      @file_to_compare = file_to_compare
      validate!
    end

    def compare
      if need_to_compare?
        @original_file.height.times do |y_axis|
          @original_file.row(y_axis).each_with_index do |pixel, x_axis|

            @file_to_compare[x_axis, y_axis] =
              if @file_to_compare[x_axis, y_axis] == pixel
                pixel
              else
                Screenshot::DIFFERENCE_COLOR
              end
          end
        end

        @difference = @file_to_compare
      end
      self
    end

    def valid?
      @error.blank?
    end

    private

    def need_to_compare?
      @original_file.present? && @file_to_compare.present? && reference_size == current_size
    end

    def reference_size
      [@original_file.width, @original_file.height]
    end

    def current_size
      [@file_to_compare.width, @file_to_compare.height]
    end

    def validate!
      @error =
        if @original_file.blank?
          :missing_reference
        elsif @file_to_compare.blank?
          :missing_current
        elsif reference_size != current_size
          :different_size
        elsif @original_file != @file_to_compare
          :different
        end
    end
  end
end
