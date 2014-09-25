require 'json'
require 'poker_player/version'
require 'poker_player/utils'

module PokerPlayer

	def self.get_move(game_state)
		if game_state.is_a? String
      game_state = JSON.parse(game_state)
    end

    current_round = game_state['rounds'].last
    current_player = game_state['players'][game_state['my_player_id']]
    current_bet = current_player['current_bet']
    board_cards = current_round['board_cards']
    hole_cards = current_player['hole_cards']    
    highest_bet = highest_bet(game_state)
    stage = game_state['rounds'].last['stage']

    ideal_move = self.send("#{stage}_ideal_move".to_sym,hole_cards, board_cards, current_player['bank_roll'])

    if ideal_move[0]=='bet'
      ideal_bet_amount = ideal_move[1]
      puts "Current Bet: #{current_bet}\nideal Bet: #{ideal_bet_amount}\nHighest Bet: #{highest_bet}"
      if current_bet+ideal_bet_amount > highest_bet
        ideal_move
      elsif current_bet+ideal_bet_amount == highest_bet
        call
      elsif current_bet+ideal_bet_amount < highest_bet
        fold
      end
    else
      ideal_move
    end

	end

  private

  #
  # GAME MOVES 
  #
  def self.bet(amount)
    ['bet', amount.to_i]
  end

  def self.call
    ['call']
  end

  def self.fold
    ['fold']
  end

  #
  # HELPER METHODS
  #
  def self.highest_bet(game_state)
    player = game_state['players'].max_by{|p| p['current_bet'] }
    return player['current_bet']
  end

  def self.pre_flop_ideal_move(hole_cards, board_cards, bank_roll)
    ranking = Utils.chen_formula(hole_cards)
    return case
      when ranking > 15 then bet bank_roll * 0.06
      when ranking <= 15 && ranking > 10 then bet bank_roll * 0.04    
      when ranking <= 10 && ranking > 5 then bet bank_roll * 0.02           
      else fold        
    end    
  end

  def self.flop_ideal_move(hole_cards, board_cards, bank_roll)
    ehs = Utils.effective_hand_strength(hole_cards.join(' '), board_cards.join(' '))
    bet_multiplier = 0.07

    if ehs > 0.5
      bet bank_roll * ehs * bet_multiplier
    else
      fold
    end
  end
  
  def self.turn_ideal_move(hole_cards, board_cards, bank_roll)
    flop_ideal_move(hole_cards, board_cards, bank_roll)
  end

  def self.river_ideal_move(hole_cards, board_cards, bank_roll)
    hs = Utils.hand_strength(hole_cards.join(' '), board_cards.join(' '))
    bet_multiplier = 0.07

    if hs > 0.5
      bet bank_roll * hs * bet_multiplier
    else
      fold
    end    
  end

end
