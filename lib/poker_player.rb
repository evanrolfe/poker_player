require 'json'
require 'poker_player/version'
require 'poker_player/utils'

module PokerPlayer

	def self.get_move(game_state)
		if game_state.is_a? String
      game_state = JSON.parse(game_state)
    end

    self.send(game_state['rounds'].last['stage'].to_sym, game_state)
	end

  private

  def self.pre_flop(game_state)
    current_round = game_state['rounds'].last
    current_player = game_state['players'][game_state['my_player_id']]

    board_cards = current_round['board_cards']
    hole_cards = current_player['hole_cards']    
    
    return 3 #Utils.chen_formula(hole_cards)
  end

  def self.flop(game_state)
    return 4
  end

  def self.turn
    
  end

  def self.river
    
  end

end
