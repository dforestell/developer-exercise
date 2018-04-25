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

  def test_card_can_say_string_name
  	assert_equal "ten of hearts", @card.string_name
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

  def test_2_card_hand_with_value_of_21_is_blackjack
  	@hand.cards << Card.new(:clubs, :ace, [1,11])
  	@hand.cards << Card.new(:spades, :ten, 10)
  	assert_equal true, @hand.blackjack?
  end

  def test_hand_of_more_than_2_cards_not_blackjack
  	@hand.cards << Card.new(:clubs, :five, 5)
  	@hand.cards << Card.new(:spades, :ten, 10)
  	@hand.cards << Card.new(:clubs, :six, 6)
  	assert_equal false, @hand.blackjack?
  end
end

class GameTest < Minitest::Test
  def setup
    @game = Game.new
    @game.start 
  end

  def test_both_hands_start_with_2_cards
  	assert_equal 2, @game.player_hand.cards.length
  	assert_equal 2, @game.dealer_hand.cards.length
  end

  def test_hit_adds_one_card_to_player_hand
    @game.hit(@game.player_hand)
    assert_equal 3, @game.player_hand.cards.length
  end

  def test_hit_adds_one_card_to_dealer_hand
    @game.hit(@game.dealer_hand)
    assert_equal 3, @game.dealer_hand.cards.length
  end

  def test_deal_recap_prints_string_commentary
    assert_kind_of String , @game.deal_recap
  end

  def test_game_over_if_player_busts
    @game2 = Game.new
    @game2.player_hand.cards << Card.new(:clubs, :five, 5)
    @game2.player_hand.cards << Card.new(:spades, :ten, 10)
    @game2.player_hand.cards << Card.new(:clubs, :seven, 7)
    assert_equal true, @game2.game_over?    
  end

  def test_game_over_if_player_dealt_blackjack
    @game2 = Game.new
    @game2.player_hand.cards << Card.new(:clubs, :ace, [1,11])
    @game2.player_hand.cards << Card.new(:spades, :ten, 10)
    assert_equal true, @game2.game_over?
  end

  def test_game_not_over_if_player_has_less_than_21
    @game2 = Game.new
    @game2.player_hand.cards << Card.new(:clubs, :five, 5)
    @game2.player_hand.cards << Card.new(:spades, :ten, 10)
    assert_equal false, @game2.game_over?
  end
end