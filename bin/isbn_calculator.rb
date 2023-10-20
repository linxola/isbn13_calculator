# frozen_string_literal: true

require_relative '../lib/isbn'

# Class to get ISBN13 code from user and display to them its check digit
class ISBNCalculator
  def initialize
    puts 'Hello! This program is used to calculate the check digit of an ISBN13 barcode.'
  end

  def run
    loop do
      print 'Please enter your ISBN13: '
      input = gets.chomp

      calculate_and_display_check_digit(input)

      answer = gets.chomp
      break unless answer == 'y'
    end
  end

  private

  def calculate_and_display_check_digit(isbn_code_string)
    check_digit = ISBN.new(isbn_code_string).calculate_check_digit

    puts "Check digit of #{isbn_code_string} ISBN13 is: #{check_digit}"
    print 'Do you want to get check digit of another ISBN13 code? (y/n) '
  rescue ISBN::LengthError, ISBN::NotOnlyDigitsError => e
    puts "Ouch, some error occured! Here is the error's text:\n #{e.message}"
    print 'Do you want to try again? (y/n) '
  end
end

ISBNCalculator.new.run if __FILE__ == $PROGRAM_NAME
