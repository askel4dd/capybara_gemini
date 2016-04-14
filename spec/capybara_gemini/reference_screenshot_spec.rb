require 'spec_helper'

RSpec.describe CapybaraGemini::ReferenceScreenshot do
  describe '.initialize' do
    it 'set screenshot absolute path' do
      reference_screenshot = described_class.new('test_file', nil)

      expect(reference_screenshot.absolute_path).to eq 'spec/fixtures/test_file.png'
    end
  end
end
