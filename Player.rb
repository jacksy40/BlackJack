class Player

  def initialize (deck, name)
    @deck = deck
    @name = name
    @player_hand = []
  @player_hand << @deck.draw!
  @player_hand << @deck.draw!
  end

  def player_hand
    @player_hand
  end

  def draw
  @player_hand << @deck.draw!
  puts"#{@name} was dealt card."
  display_hand
  end

  def display_hand
    array = []
    @player_hand.each do |card|
       array << card.rank + card.suit
    end
    puts array.join(' ') + " total is  " + hand_value.to_s
  end
  def hand_value
    total = 0
    ace = 0
    @player_hand.each do |card|
      ace += 1 if card.rank == "A"
      total += card.value
    end
    if ace == 1
        total -= 10 if total > 21
      elsif ace > 2
        (ace-1).times do
        total -= 10 if total > 21
      end
    end
    return total
  end

  def stop
    hand_value
  end

end
