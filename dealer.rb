# frozen_string_literal: true

require_relative 'player'

class Dealer < Player
  SKIP_SCORE = 17
  def take_card?
    card_sum < SKIP_SCORE && @hand.cards.size == 2
  end

  def hide_cards
    @hand.cards.map { '*' }.join(' ')
  end
end
