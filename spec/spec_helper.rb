require 'capybara_gemini/rspec'
require 'capybara/spec/spec_helper'

RSpec.configure do |config|
  Capybara::SpecHelper.configure(config)
  CapybaraGemini.configure do |config|
    config.reference_screenshots_path = 'spec/fixtures'
  end

  config.before(:each) do |example|
    example.metadata[:dir_entries] = Pathname.new(CapybaraGemini.reference_screenshots_path).children.map(&:to_s)
  end

  config.after(:each) do |example|
    current_entries = Pathname.new(CapybaraGemini.reference_screenshots_path).children.map(&:to_s)
    entries_to_delete = current_entries - example.metadata[:dir_entries]
    entries_to_delete.each do |entry_name|
      entry = Pathname.new(entry_name)
      if entry.file?
        entry.delete
      else
        entry.rmdir
      end
    end
  end

  config.before(:each, :js) do
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1024, 768) # width, height
  end
end
