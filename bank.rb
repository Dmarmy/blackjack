# frozen_string_literal: true

class Bank
  attr_accessor :amount

  class << self
    attr_accessor :bank
  end

  @bank = 0
  DEFAULT_BANK = 100
  BET = 10

  def initialize(player)
    @amount = DEFAULT_BANK
    @player = player
  end

  def withdraw
    self.class.bank += BET
    self.amount -= BET
  end

  def deposit
    self.amount += self.class.bank
    self.class.bank = 0
  end

  def return_bet
    self.amount += BET
    self.class.bank = 0
  end
end
