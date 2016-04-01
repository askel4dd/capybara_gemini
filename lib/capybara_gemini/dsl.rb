module CapybaraGemini
  module DSL
    RSpec::Matchers.define :match_reference do |file_name|
      match do |page|
        reference_screenshot_stream = ReferenceScreenshot.new(file_name, page).fetch
        current_screenshot_stream = CurrentScreenshot.new(file_name, page).create
        @comparator = Comparator.new(reference_screenshot_stream, current_screenshot_stream).compare
        @comparator.difference.present? ? @comparator.difference.save('difference') : @comparator.valid?
      end

      failure_message do |*|
        case @comparator.error
          when :different then
            'Images are different.'
          when :missing_reference then
            'Reference screenshot is missing.'
          when :missing_current then
            'Current screenshot is missing.'
          when :different_size then
            'Images size is different.'
        end
      end
    end
  end
end
