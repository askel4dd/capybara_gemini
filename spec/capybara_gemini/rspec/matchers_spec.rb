require 'spec_helper'

RSpec.describe CapybaraGemini::RSpecMatchers, type: :feature, js: true do
  describe 'match_reference matcher' do
    context 'reference screenshot is present' do
      it 'compare reference and current screenshot' do
        visit '/'

        expect(page).to match_reference('test')
      end

      it 'create result image with pixel difference' do
        visit '/'

        expect(page).to match_reference('test')
      end
    end

    context 'reference screenshot is not present' do
      it 'create new reference screenshot' do
        visit '/'

        expect(page).to match_reference('new_reference_screenshot')
        expect(File).to exist(Rails.root.join('spec/fixtures/screenshots', 'new_reference_screenshot.png'))
      end
    end
  end
end
