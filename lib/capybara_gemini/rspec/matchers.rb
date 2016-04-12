module CapybaraGemini
  module RSpecMatchers
    ::RSpec::Matchers.define :match_reference do |file_name|
      match do |page|
        reference_screenshot = ReferenceScreenshot.new(file_name, page).fetch
        current_screenshot = CurrentScreenshot.new(file_name, page).create
        @comparator = Comparator.new(reference_screenshot, current_screenshot).compare
        @comparator.valid?
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
