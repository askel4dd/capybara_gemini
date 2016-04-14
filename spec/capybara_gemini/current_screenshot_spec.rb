require 'spec_helper'

RSpec.describe CapybaraGemini::CurrentScreenshot do
  describe '.initialize' do
    it 'set screenshot dirname location' do
      current_screenshot = described_class.new('root_page', nil)

      expect(current_screenshot.dirname).to eq(Dir.tmpdir + '/root_page')
    end

    it 'set screenshot absolute path' do
      current_screenshot = described_class.new('root_page', nil)

      expect(current_screenshot.absolute_path).to eq(Dir.tmpdir + '/root_page/current.png')
    end
  end
end
