module PokerPlayer
  module Utils

    def self.chen_formula(hole_cards)
      output = `cd jruby && jruby chen_formula.rb #{hole_cards}`
      result = JSON.parse(output)
      return result['ranking']
    end

    def self.hand_potential(hole_cards, board_cards)
      output = `cd jruby && jruby hand_potential.rb #{hole_cards} #{board_cards}`
      return JSON.parse(output)
    end

    def self.hand_strength(hole_cards, board_cards)
      output = `cd jruby && jruby hand_strength.rb #{hole_cards} #{board_cards}`
      result = JSON.parse(output)
      return result['hand_strength']      
    end

    def self.effective_hand_strength(hole_cards, board_cards)
      hp = hand_potential(hole_cards, board_cards)
      ppot = hp['ppot']
      npot = hp['npot']
      hs = hand_strength(hole_cards, board_cards)
      return (hs * (1 - npot)) + ((1 - hs) * ppot)
    end

  end
end
 
