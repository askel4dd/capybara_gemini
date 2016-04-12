require 'capybara_gemini/rspec'
require 'capybara/spec/spec_helper'

RSpec.configure do |config|
  Capybara::SpecHelper.configure(config)
  CapybaraGemini.configure do |config|
    config.reference_screenshots_path = 'spec/fixtures'
  end

  config.before(:each) do |example|
    example.metadata[:dir_entries] = Dir.entries(CapybaraGemini.reference_screenshots_path)
  end

  config.after(:each) do |example|
    files_to_delete = Dir.entries(CapybaraGemini.reference_screenshots_path) - example.metadata[:dir_entries]
    files_to_delete.each do |file_name|
      File.delete(File.join(CapybaraGemini.reference_screenshots_path, file_name))
    end
  end
end
