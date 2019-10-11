# frozen_string_literal: true

require_relative 'deck'
require_relative 'card'
require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :bank, :cards, :hand

  def initialize(name)
    @name = name
    @bank = 0
    @hand = Hand.new
  end

  def take_card(cards)
    if @hand.cards
      @hand.cards += cards
    else
      @hand.cards = cards
    end
  end

  def two_cards?
    @hand.two_cards?
  end

  def card_sum
    @hand.card_sum
  end

  def return_cards
    @hand.cards = nil
  end

  def player_cards
    (@hand.cards.map { |card| "#{card.value}#{card.suit}" }).join(' ')
  end
end
