# frozen_string_literal: true

require_relative '../lib/isbn'

RSpec.describe ISBN do
  subject(:isbn) { described_class.new(isbn_string) }

  let(:isbn_string) { nil }

  context 'when passing invalid isbn code to a class' do
    context 'when there are not only digits in the code' do
      let(:isbn_string) { '978oi43007234' }

      it 'raises NotOnlyDigitsError' do
        expect { ISBN.new(isbn_string) }.to raise_error(ISBN::NotOnlyDigitsError)
      end
    end

    context 'when there are not exactly 13 digits in the code' do
      let(:isbn_string) { '97843007234' }

      it 'raises LengthError' do
        expect { ISBN.new(isbn_string) }.to raise_error(ISBN::LengthError)
      end
    end
  end

  describe '#calculate_check_digit' do
    let(:isbn_string) { '9780143007234' }

    it 'calculates check digit of isbn code' do
      isbn = ISBN.new(isbn_string)
      expect(isbn.calculate_check_digit).to eq(0)
    end
  end
end
