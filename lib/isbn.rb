# frozen_string_literal: true

# Class for calculation ISBN13 code's check digit
class ISBN
  class NotOnlyDigitsError < StandardError; end
  class LengthError < StandardError; end

  def initialize(isbn_string)
    @isbn = isbn_string
    valid_isbn?
  end

  def calculate_check_digit
    sum = 0
    @isbn.chars.map(&:to_i).each_with_index do |digit, index|
      sum += index.even? ? digit * 1 : digit * 3
    end

    result = 10 - (sum % 10)
    result == 10 ? 0 : result
  end

  private

  def valid_isbn?
    unless @isbn.match?(/^\d+$/)
      raise NotOnlyDigitsError, 'Validation error: ISBN13 must consist of only digits'
    end

    unless @isbn.match?(/^\d{13}$/)
      raise LengthError, 'Validation error: ISBN13 must consist of exactly 13 digits'
    end

    true
  end
end
