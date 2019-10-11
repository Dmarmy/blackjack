# frozen_string_literal: true

class Interface
  def get_user_name
    print 'Enter your name: '
    @name = gets.chomp.to_s
  end

  def balance_message(user_amount, dealer_amount)
    puts "#{@name}'s balance:  #{user_amount}$. Dealer's: #{dealer_amount}$"
  end

  def user_move_menu(user_cards, user_cards_sum, dealer_cards, add_card)
    puts "\n#{@name}'s cards: #{user_cards}, Score: #{user_cards_sum}"
    puts "Dealer's cards: #{dealer_cards}"
    puts 'Enter 1 to open cards'
    puts 'Enter 2 to skip turn '
    puts 'Enter 3 to take a card ' if add_card
    gets.chomp.to_i
  end

  def show_cards(user_cards, user_sum, dealer_cards, dealer_sum)
    puts "\n#{@name}'s cards: #{user_cards}, Score: #{user_sum}"
    puts "Dealer cards: #{dealer_cards}, Score: #{dealer_sum}\n"
  end

  def show_game_result(winner)
    case winner
    when :nobody
      puts "There're no winners"
    when :draw
      puts 'Draw'
    when :user
      puts "#{@name} won"
    when :dealer
      puts 'Dealer won'
    end
  end

  def try_again_menu
    puts 'Play again? (1 - yep, 0 - nope)'
    gets.chomp.to_i
  end

  def dealer_win(user_amount)
    puts "#{@name}'s balance: #{user_amount}$. Not enough money to play."
  end

  def user_win(dealer_amount)
    puts "Dealer's balance: #{dealer_amount}$. You won!"
  end

  def cls
    system 'clear'
  end
end
