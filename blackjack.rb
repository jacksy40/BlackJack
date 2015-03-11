#!/usr/bin/env ruby

# YOUR CODE HERE
require'pry'

class Game
  def initialize
    deck = Deck.new
    puts "Please enter your name,"
    name = gets.chomp
    player = Player.new(deck, name )
    dealer = Player.new(deck, "Dealer")

    puts "Lets Play BlackJack"
    choice = nil
    if player.player_hand.hand_value == 21
      puts "BlackJack you win!"
    elsif
      dealer.player_hand.hand_value == 21
      puts " Dealer Sucks"
    else
      until choice =="s" || player.player_hand.hand_value > 21
        puts "H to draw another card or S to stand"
        player.display_hand
        choice = gets.chomp.downcase
        if choice == "h"
          player.draw(deck)
        elsif choice == "s"
          break
        end
      end

      if player.player_hand.hand_value > 21
        puts "Busted! Dealer Wins."
      else
        puts "#{name} stands with #{player.player_hand.hand_value}"
        dealer.display_hand
        loop do
          break if dealer.player_hand.hand_value > 17
          dealer.draw(deck)
        end
        if dealer.player_hand.hand_value < 21
          puts "Dealer stands with #{dealer.player_hand.hand_value}"
        end
        if dealer.player_hand.hand_value == player.player_hand.hand_value
          puts "=>Push<="
        elsif dealer.player_hand.hand_value > 21
          puts "Dealer Busts! #{name} wins!"
        elsif dealer.player_hand.hand_value < player.player_hand.hand_value
          puts "Dealer Loses! #{name} wins!"
        elsif  player.player_hand.hand_value < dealer.player_hand.hand_value
          puts "You lose! "
        end
      end
    end
  end
end

class PlayingCard
  attr_reader :rank, :suit, :value
  def initialize (rank, suit)
    @rank = rank
    @suit = suit
    if facecard?
      @value = 10
    elsif @rank == 'A'
      @value = 11
    else
      @value = @rank.to_i
    end
  end

  def facecard?
  ['J','Q','K'].include?@rank
  end
end

SUITS = ['♠', '♥', '♦', '♣']
  RANKS = ['2', '3','4','5','6','7','8','9','10','J','Q','K','A']

class Deck
  def initialize
  @collection = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @collection << PlayingCard.new(rank, suit)
      end
    end
    @collection.shuffle!
  end

  def draw!
    @collection.pop
  end

  def collection
    @collection
  end

end

class Hand
  attr_accessor :hand
  def initialize (deck)
    @hand = []
    @hand << deck.draw!
    @hand << deck.draw!
  end

  def hand_value
    total = 0
    ace = 0
    @hand.each do |card|
      ace += 1 if card.rank == "A"
      total += card.value
    end
    if ace > 0
      ace.times do
        total -= 10 if total > 21
      end
    end
    return total
  end
end

class Player
  attr_reader :player_hand
  def initialize (deck, name)
    @name = name
  @player_hand = Hand.new(deck)
  end
  def display_hand
    array = []
    @player_hand.hand.each do |card|
       array << card.rank + card.suit
    end
    puts array.join(' ') + " total is  " + @player_hand.hand_value.to_s
  end

  def draw(deck)
  @player_hand.hand << deck.draw!
  puts"#{@name} was dealt card."
  display_hand
  end
  def stop
    @player_hand.hand_value
  end
end
deck = Deck.new
game = Game.new
