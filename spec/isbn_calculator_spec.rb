# frozen_string_literal: true

require_relative '../lib/isbn'
require_relative '../bin/isbn_calculator'

RSpec.describe ISBNCalculator do
  subject(:isbn_calculator) { described_class.new }

  describe '#run' do
    context 'when checking only 1 isbn' do
      context 'when isbn is valid' do
        it 'calculates and displays the check digit' do
          allow(isbn_calculator).to receive(:gets).and_return('9780143007234', 'n')

          expect { isbn_calculator.run }
            .to output(
              'Please enter your ISBN13: ' \
              "Check digit of 9780143007234 ISBN13 is: 0\n" \
              'Do you want to get check digit of another ISBN13 code? (y/n) '
            ).to_stdout
        end
      end

      context 'when isbn is invalid' do
        context 'when isbn consists not only digits' do
          it 'displays an error message' do
            allow(isbn_calculator).to receive(:gets).and_return('978oi43007234', 'n')

            expect { isbn_calculator.run }.to output(
              'Please enter your ISBN13: ' \
              "Ouch, some error occured! Here is the error's text:\n " \
              "Validation error: ISBN13 must consist of only digits\n" \
              'Do you want to try again? (y/n) '
            ).to_stdout
          end
        end

        context 'when isbn length is not exactly 13 digits' do
          it 'displays an error message' do
            allow(isbn_calculator).to receive(:gets).and_return('97843007234', 'n')

            expect { isbn_calculator.run }.to output(
              'Please enter your ISBN13: ' \
              "Ouch, some error occured! Here is the error's text:\n " \
              "Validation error: ISBN13 must consist of exactly 13 digits\n" \
              'Do you want to try again? (y/n) '
            ).to_stdout
          end
        end
      end
    end

    context 'when checking 2 isbns' do
      context 'when all 2 isbns are valid' do
        it 'calculates and displays the check digits' do
          allow(isbn_calculator).to receive(:gets)
            .and_return('9780143007234', 'y', '9780143207234', 'n')

          expect { isbn_calculator.run }
            .to output(
              'Please enter your ISBN13: ' \
              "Check digit of 9780143007234 ISBN13 is: 0\n" \
              'Do you want to get check digit of another ISBN13 code? (y/n) ' \
              'Please enter your ISBN13: ' \
              "Check digit of 9780143207234 ISBN13 is: 4\n" \
              'Do you want to get check digit of another ISBN13 code? (y/n) '
            ).to_stdout
        end
      end

      context 'when one of isbns is invalid' do
        context 'when the invalid isbn consists not only digits' do
          it 'displays an error message' do
            allow(isbn_calculator).to receive(:gets)
              .and_return('9780143007234', 'y', '978oi43007234', 'n')

            expect { isbn_calculator.run }.to output(
              'Please enter your ISBN13: ' \
              "Check digit of 9780143007234 ISBN13 is: 0\n" \
              'Do you want to get check digit of another ISBN13 code? (y/n) ' \
              'Please enter your ISBN13: ' \
              "Ouch, some error occured! Here is the error's text:\n " \
              "Validation error: ISBN13 must consist of only digits\n" \
              'Do you want to try again? (y/n) '
            ).to_stdout
          end
        end

        context 'when the invalid isbn length is not exactly 13 digits' do
          it 'displays an error message' do
            allow(isbn_calculator).to receive(:gets)
              .and_return('9780143007234', 'y', '97843007234', 'n')

            expect { isbn_calculator.run }.to output(
              'Please enter your ISBN13: ' \
              "Check digit of 9780143007234 ISBN13 is: 0\n" \
              'Do you want to get check digit of another ISBN13 code? (y/n) ' \
              'Please enter your ISBN13: ' \
              "Ouch, some error occured! Here is the error's text:\n " \
              "Validation error: ISBN13 must consist of exactly 13 digits\n" \
              'Do you want to try again? (y/n) '
            ).to_stdout
          end
        end
      end
    end
  end
end
