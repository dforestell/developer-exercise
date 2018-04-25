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
    @cards.each do |card|
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

  def deal_recap
    p "Player was dealt a #{@player_hand.cards[0].string_name} and #{@player_hand.cards[1].string_name}"
    p "Dealer has #{@dealer_show_card.string_name} showing"
  end
  def hit(hand)
    hand.cards << @deck.deal_card
  end

  def game_over?
    if @player_hand.blackjack? || @player_hand.bust?
      true
    elsif @dealer_hand.value >= 17
      true
    else
      false
    end
  end
end