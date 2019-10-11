# frozen_string_literal: true

class Card
  attr_reader :suit, :value

  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = %w[♦ ♠ ♥ ♣].freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
    validate!
  end

  private

  def validate!
    raise 'Not valid value' unless VALUES.include?(@value)
    raise 'Not valid suit' unless SUITS.include?(@suit)
  end
end
