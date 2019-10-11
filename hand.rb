# frozen_string_literal: true

require_relative 'player'
require_relative 'card'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def card_sum
    values = assign_values
    values.each do |value|
      if values.sum < 21 && value == 1
        values[values.index(value)] = 11 if values.sum + 10 < 22
      end
    end
    values.sum
  end

  def assign_values
    values = []
    cards.each do |card|
      values << if %w[J Q K].include?(card.value)
                  10
                elsif card.value == 'A'
                  1
                else
                  card.value
                end
    end
    values
  end

  def two_cards?
    @cards.size == 2
  end
end
