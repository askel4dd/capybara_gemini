require 'spec_helper'

describe CapybaraGemini do
  describe '.configure' do
    it 'set action to passed value' do
      expect {
        described_class.configure { |config| config.action = 'update' }
      }.to change { described_class.action }.to('update')
    end
  end

  describe '.reference_screenshots_path', skip: true do
    it 'set reference_screenshots_path to passed value' do
      expect {
        described_class.configure { |config| config.reference_screenshots_path = '/test/path/to' }
      }.to change { described_class.reference_screenshots_path }.to('/test/path/to')
    end
  end
end
