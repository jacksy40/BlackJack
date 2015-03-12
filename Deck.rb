require_relative 'Card'
require 'pry'

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

deck = Deck.new
