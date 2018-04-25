require 'minitest/autorun'
require_relative 'blackjack.rb'

class CardTest < Minitest::Test
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end
  
  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Minitest::Test
  def setup
    @deck = Deck.new
  end
  
  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end
  
  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    refute_includes(@deck.playable_cards, card)
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end

class HandTest < Minitest::Test
  def setup
    @hand = Hand.new
  end

  def test_value_sums_correclty
  	@hand.cards << Card.new(:clubs, :ten, 10)
  	@hand.cards << Card.new(:spades, :ten, 10)
  	assert_equal 20, @hand.value
  end

  def test_ace_knows_when_11
  	@hand.cards << Card.new(:clubs, :ten, 10)
  	@hand.cards << Card.new(:spades, :ace, [1,11])
  	assert_equal 21, @hand.value

  end

  def test_ace_knows_when_1
  	@hand.cards << Card.new(:clubs, :ten, 10)
  	@hand.cards << Card.new(:spades, :ten, 10)
  	@hand.cards << Card.new(:spades, :ace, [1,11])
  	assert_equal 21, @hand.value
  end

  def test_hand_bust_when_value_greater_than_21
  	@hand.cards << Card.new(:clubs, :ten, 10)
  	@hand.cards << Card.new(:spades, :ten, 10)
  	assert_equal false, @hand.bust?

  	@hand.cards << Card.new(:clubs, :five, 5)
  	assert_equal true, @hand.bust?
  end
end