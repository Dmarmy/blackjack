# frozen_string_literal: true

class Interface
  PLAYER_ACTIONS = ['Skip', 'Take card', 'Open cards'].freeze
  RESULT_MESSAGE = { win: 'You won', losing: 'You lose', draw: 'Draw' }.freeze

  attr_reader :game

  def initialize(game)
    @game = game
  end

  def view_player_info(player, hide = false)
    puts "Player: #{player.name}\nScore: #{hide ? '**' : player.score}\nBalance: #{player.bank}\n"
    cards_list = ''
    player.cards.each { |card| cards_list += hide ? ' **' : " #{card}" }
    puts "Cards: #{cards_list}"
    puts "____________________\n"
  end

  def print_game_status(game)
    cls
    view_player_info(game.player)
    view_player_info(game.dealer, game.in_progress?)

    puts ''
    puts RESULT_MESSAGE.fetch(game.result) if game.finished?
  end

  def get_player_choice
    puts "Choose option:\n"
    PLAYER_ACTIONS.each.with_index(1) { |action, num| puts "#{num}. #{action}" }
    gets.to_i - 1
  end

  def next_game_request
    if game.players_bank_zero?
      puts 'Not enough money to play'
      return
    end

    puts 'Play again? (1 - yep, 0 - nope)'
    return if gets.to_i.zero?

    game.start_game
  end

  def cls
    system 'clear'
  end
end
