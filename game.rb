# frozen_string_literal: true

require_relative 'bank'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'interface'

class Game
  MAX_CARDS = 3
  MAX_SCORE = 21

  attr_reader :deck

  def initialize
    @interface = Interface.new
    @user = Player.new(@interface.get_user_name)
    @dealer = Dealer.new('Dealer')
    @user.bank = Bank.new(@user)
    @dealer.bank = Bank.new(@dealer)

    new_game
  end

  def new_game
    loop do
      @interface.cls
      @deck = Deck.new
      if @user.hand.cards
        @user.return_cards
        @dealer.return_cards
      end
      @user.take_card(@deck.take_start_cards)
      @dealer.take_card(@deck.take_start_cards)
      return unless start_game
    end
  end

  protected

  def start_game
    start_bet
    user_move
    try_again?
  end

  def start_bet
    @user.bank.withdraw
    @dealer.bank.withdraw
    @interface.balance_message(@user.bank.amount, @dealer.bank.amount)
  end

  def user_move
    answer = @interface.user_move_menu(@user.player_cards, @user.card_sum, @dealer.hide_cards, @user.two_cards?)
    case answer
    when 1
      open_cards
    when 2
      dealer_move
    when 3
      if @user.two_cards?
        @user.take_card(@deck.take_card)
        dealer_move
      else
        exit
      end
    end
  end

  def dealer_move
    @dealer.take_card(@deck.take_card) if @dealer.take_card?
    next_move?
  end

  def next_move?
    check_cards_count ? open_cards : user_move
  end

  def check_cards_count
    @dealer.hand.cards.size == MAX_CARDS && @user.hand.cards.size == MAX_CARDS
  end

  def open_cards
    @interface.show_cards(@user.player_cards, @user.card_sum, @dealer.player_cards, @dealer.card_sum)
    @interface.show_game_result(winner)
    case winner
    when :draw
      return_bet(@user, @dealer)
    when :user
      @user.bank.deposit
    when :dealer
      @dealer.bank.deposit
    end
    check_pleer_bank
  end

  def winner
    user_card_sum = @user.card_sum
    dealer_card_sum = @dealer.card_sum
    if user_card_sum > MAX_SCORE && dealer_card_sum > MAX_SCORE
      return :nobody
    elsif user_card_sum == dealer_card_sum
      return :draw
    elsif user_card_sum <= MAX_SCORE && dealer_card_sum > MAX_SCORE
      return :user
    elsif dealer_card_sum <= MAX_SCORE && user_card_sum > MAX_SCORE
      return :dealer
    elsif dealer_card_sum > user_card_sum
      return :dealer
    elsif dealer_card_sum < user_card_sum
      return :user
    end
  end

  def return_bet(*players)
    players.each { |player| player.bank.return_bet }
  end

  def try_again?
    answer = @interface.try_again_menu
    answer == 1
  end

  def check_pleer_bank
    if @user.bank.amount < 10
      @interface.dealer_win(@user.bank.amount)
      exit
    elsif @dealer.bank.amount < 10
      @interface.user_win(@dealer.bank.amount)
      exit
    end
  end
end
