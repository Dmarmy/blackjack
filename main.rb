# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'game'
require_relative 'interface'

puts "Enter your name:\n"
player_name = gets.chomp

player = Player.new(player_name)

game = Game.new(player)

interface = Interface.new(game)

while game.in_progress?
  interface.print_game_status(game)
  if game.player_turn
    game.next_player_turn(interface.get_player_choice)
  else
    game.next_dealer_turn
  end
  interface.print_game_status(game)

  interface.next_game_request if game.finished?
end
