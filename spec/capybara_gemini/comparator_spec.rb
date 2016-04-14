require 'spec_helper'
require 'chunky_png'

RSpec.describe CapybaraGemini::Comparator do
  describe '#compare' do
    context 'different screenshots' do
      it 'compare screenshots' do
        expect(File).to_not exist('spec/fixtures/difference.png')

        reference_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_reference.png')
        current_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_with_difference.png')
        reference_screenshot = double(file: reference_file)
        current_screenshot = double(file: current_file, dirname: 'spec/fixtures/')

        comparator = described_class.new(reference_screenshot, current_screenshot).compare

        expect(comparator).to_not be_valid
        expect(comparator.error).to eq(:different)
        expect(File).to exist('spec/fixtures/difference.png')
      end

      it 'mark difference between screenshots' do
        reference_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_reference.png')
        current_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_with_difference.png')

        expect(reference_file.inspect.scan(/#ee82eeff/).count).to eq 0
        expect(current_file.inspect.scan(/#ee82eeff/).count).to eq 0

        reference_screenshot = double(file: reference_file)
        current_screenshot = double(file: current_file, dirname: 'spec/fixtures/')

        described_class.new(reference_screenshot, current_screenshot).compare

        difference_image = ChunkyPNG::Image.from_file('spec/fixtures/difference.png')
        number_of_different_pizels = 326
        # ee82eeff is a hex code of screenshot difference color.
        expect(difference_image.inspect.scan(/#ee82eeff/).count).to eq number_of_different_pizels
      end
    end

    context 'reference file is not present' do
      it 'set missing reference file error' do
        reference_screenshot = double(file: nil)
        current_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_with_difference.png')
        current_screenshot = double(file: current_file, dirname: 'spec/fixtures/')

        comparator = described_class.new(reference_screenshot, current_screenshot).compare

        expect(comparator).to_not be_valid
        expect(comparator.error).to eq(:missing_reference)
      end
    end

    context 'current file is not present' do
      it 'set missing current file error' do
        reference_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_reference.png')
        reference_screenshot = double(file: reference_file)
        current_screenshot = double(file: nil, dirname: 'spec/fixtures/')

        comparator = described_class.new(reference_screenshot, current_screenshot).compare

        expect(comparator).to_not be_valid
        expect(comparator.error).to eq(:missing_current)
      end
    end

    context 'images with different size' do
      it 'set different size error' do
        reference_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_reference.png')
        current_file = ChunkyPNG::Image.from_file('spec/fixtures/frog_different_size.png')
        reference_screenshot = double(file: reference_file)
        current_screenshot = double(file: current_file, dirname: 'spec/fixtures/')

        comparator = described_class.new(reference_screenshot, current_screenshot).compare

        expect(comparator).to_not be_valid
        expect(comparator.error).to eq(:different_size)
      end
    end
  end
end
