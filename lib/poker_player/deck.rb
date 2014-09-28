module PokerPlayer
  class Deck

    attr_reader :cards

    def initialize(cards = nil)
      if cards.nil?
        @cards = []
        Card::SUITS.each_byte do |suit|
          # careful not to double include the aces...
          Card::FACES[1..-1].each_byte do |face|
            @cards.push(Card.new(face.chr, suit.chr))
          end
        end
       else
        @cards = cards
      end
    end

    def put_back(card)
      @cards << card unless @cards.include?(card)
    end

    def shuffle
      @cards = @cards.sort_by { rand }
      return self
    end

    # removes a single card from the top of the deck and returns it
    # synonymous to poping off a stack
    def deal(card = nil)
      if card.nil?
        return @cards.pop
      else
        @cards.reject!{ |c| c==card }
        return card
      end
    end

    # delete an array or a single card from the deck
    # converts a string to a new card, if a string is given
    def burn(burn_cards)
      return false if burn_cards.is_a?(Integer)
      if burn_cards.is_a?(Card) || burn_cards.is_a?(String)
        burn_cards = [burn_cards]
      end

      burn_cards.map! do |c|
        c = Card.new(c) unless c.class == Card
        @cards.delete(c)
      end
      true
    end

    # return count of the remaining cards
    def size
      @cards.size
    end

    def empty?
      @cards.empty?
    end

    def clone
      Deck.new(@cards.map{|c| c.to_card })
    end

  end
end
