#!/usr/bin/env ruby
require'pry'
require_relative 'Card'
require_relative 'Deck'
require_relative 'Player'

class BlackJack
  def initialize
    deck = Deck.new
    puts "Please enter your name,"
    name = gets.chomp
    player = Player.new(deck, name )
    dealer = Player.new(deck, "Dealer")

    puts "Lets Play BlackJack"
    choice = nil
    if player.hand_value == 21
      puts "BlackJack you win!"
    elsif
      dealer.hand_value == 21
      puts " Dealer Sucks"
    else
      until choice =="s" || player.hand_value > 21
        puts "H to draw another card or S to stand"
        player.display_hand
        choice = gets.chomp.downcase
        if choice == "h"
          player.draw
        elsif choice == "s"
          break
        end
      end

      if player.hand_value > 21
        puts "Busted! Dealer Wins."
      else
        puts "#{name} stands with #{player.hand_value}"
        dealer.display_hand
        loop do
          break if dealer.hand_value > 17
          dealer.draw
        end
        if dealer.hand_value < 21
          puts "Dealer stands with #{dealer.hand_value}"
        end
        if dealer.hand_value == player.hand_value
          puts "=>Push<="
        elsif dealer.hand_value > 21
          puts "Dealer Busts! #{name} wins!"
        elsif dealer.hand_value < player.hand_value
          puts "Dealer Loses! #{name} wins!"
        elsif  player.hand_value < dealer.hand_value
          puts "You lose! "
        end
      end
    end
  end
end

deck = Deck.new
game = BlackJack.new
