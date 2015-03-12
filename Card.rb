class PlayingCard
  attr_reader :rank, :suit, :value
  def initialize (rank, suit)
    @rank = rank
    @suit = suit
    facecard?
  end
  def facecard?
    if ['J','Q','K'].include?@rank
      @value = 10
    elsif @rank =="A"
      @value = 11
    else
      @value = @rank.to_i
    end
  end
end
