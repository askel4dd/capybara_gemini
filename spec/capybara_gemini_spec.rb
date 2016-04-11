require 'spec_helper'

describe CapybaraGemini do
  describe '.configure' do
    it 'set action to passed value' do
      expect {
        described_class.configure { |config| config.action = 'update' }
      }
        .to change { described_class.action }.to('update')
    end
  end
end
