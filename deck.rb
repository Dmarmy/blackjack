# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = build_deck
  end

  def take_card(number = 1)
    @deck.pop(number)
  end

  def take_start_cards
    take_card(2)
  end

  protected

  def build_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck.shuffle
  end
end
