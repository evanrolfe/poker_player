module PokerPlayer
  module Calculations

     #Takes a string like "2h3h"
    def self.effective_hand_strength(hole_cards, board_cards)
      pe = PokerEval.new
      result = pe.effective_hand_strength(hole_cards, board_cards)
      return result[:ehs]
    end

    def self.hand_potential(hole_cards, board_cards)
      pe = PokerEval.new
      (ppot, npot) = pe.hand_potential(hole_cards, board_cards)
      return ppot, npot
    end

    def self.sklansky_group(hole_cards)
      pe = PokerEval.new
      return pe.hand_to_sklansky_group(hole_cards)
    end

    def self.hand_strength(hole_cards, board_cards)
      pe = PokerEval.new
      return pe.str_to_hs(hole_cards, board_cards)
    end

  end
end
