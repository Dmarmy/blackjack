# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'game'
require_relative 'interface'

puts "What's your name?"
player_name = gets.chomp

player = Player.new(player_name)

game = Game.new(player)

# interface = Interface.new(game)
game.player.view_info
game.dealer.view_info(true)
