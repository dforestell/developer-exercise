class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end

  def string_name
    "#{@name.to_s} of #{@suite.to_s}"
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def value
    current_value = 0
    #sort cards by name descending so that ace can take appropriate value
    sorted_cards = @cards.sort_by { |card| card.name }.reverse
    sorted_cards.each do |card|
      if card.value.kind_of?(Array)
        ace_value = 11
        ace_value = 1 if current_value + ace_value > 21
        current_value += ace_value
      else
        current_value += card.value
      end
    end
    current_value
  end

  def bust?
    value > 21
  end

  def blackjack?
    value == 21 && @cards.length == 2
  end
end

class Game
  attr_accessor :player_hand, :dealer_hand, :dealer_show_card
  
  def initialize
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    @deck = Deck.new
    @dealer_show_card = nil
  end

  def start
    2.times do
      @player_hand.cards << @deck.deal_card
      @dealer_hand.cards << @deck.deal_card
    end
    @dealer_show_card = @dealer_hand.cards[-1]
  end

  def play
    start
    deal_recap
    player_turn
    dealer_turn if game_over? == false
    winner? if game_over? == false
  end

  def deal_recap
    p "Player was dealt a #{@player_hand.cards[0].string_name} and #{@player_hand.cards[1].string_name}"
    p "Dealer has #{@dealer_show_card.string_name} showing"
  end
  def hit(hand)
    new_card = @deck.deal_card
    hand.cards << new_card
    hit_recap(hand)
  end
   
  def hit_recap(hand)
    if hand == @player_hand
      p "Player hits and was delt a #{hand.cards[-1].string_name}"
    else
      p "Dealer hits and was delt a #{hand.cards[-1].string_name}"
    end
  end


  def game_over?
    if @player_hand.blackjack? || @player_hand.bust? || @dealer_hand.bust?
      true
    else
      false
    end
  end

  
  def player_turn
    until @player_hand.value >= 16
      hit(@player_hand)
    end
    player_status
  end

  def player_status
    if @player_hand.bust?
      p "DEALER WINS player bust with #{@player_hand.value}"
    elsif @player_hand.blackjack?
      p "BLACKJACK, PLAYER WINS"
    else
      p "Player stays with #{@player_hand.value}....Dealers turn"
    end
  end

  def dealer_status
    if @dealer_hand.bust?
      p "Player wins, Dealer bust with #{@dealer_hand.value}"
    else
      p "Dealer Stays with #{@dealer_hand.value}"
    end
  end

  def dealer_turn
    p "Dealer flipped over a #{@dealer_hand.cards[0].string_name}"
    until @dealer_hand.value >= 17
      hit(@dealer_hand)
    end
    dealer_status
  end
  
  def winner?
    if @player_hand.value > @dealer_hand.value
      p "Player wins #{@player_hand.value} to #{@dealer_hand.value}"
    elsif @player_hand.value == @dealer_hand.value
      p "We have a tie at #{@player_hand.value}"
    else
      p "Dealer Wins #{@dealer_hand.value} to #{@player_hand.value}"
    end
  end
end