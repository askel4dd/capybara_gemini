require 'spec_helper'

RSpec.describe CapybaraGemini::RSpecMatchers, type: :feature, js: true do
  describe 'match_reference matcher' do
    context 'reference screenshot is present' do
      it 'compare reference and current screenshot' do
        expect(File).to exist(File.join(CapybaraGemini.reference_screenshots_path, 'root_page.png'))

        visit '/'

        expect(page).to match_reference('root_page')
      end

      it 'compare different reference and current screenshot' do
        expect(File).to exist(File.join(CapybaraGemini.reference_screenshots_path, 'root_page_with_difference.png'))

        visit '/'

        expect(page).to_not match_reference('root_page_with_difference')
      end
    end

    context 'reference screenshot is not present' do
      it 'create new reference screenshot' do
        expect(File).to_not exist(File.join(CapybaraGemini.reference_screenshots_path, 'new_root_page.png'))

        visit '/'

        expect(page).to match_reference('new_root_page')
        expect(File).to exist(File.join(CapybaraGemini.reference_screenshots_path, 'new_root_page.png'))
      end
    end
  end
end
