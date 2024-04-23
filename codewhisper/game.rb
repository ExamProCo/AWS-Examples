# A game class for a terminal game that will be a simple game of black jack
class Game
    attr_accessor :player, :dealer, :deck
    def initialize(player, dealer, deck)
        @player = player
        @dealer = dealer
        @deck = deck
        @deck.shuffle!
        @player.hand = [@deck.draw, @deck.draw]
    end
    