require 'json'

require 'rubygems'
require 'bundler'
require 'rake'
require 'ffi'
require 'ruby-poker'
require 'pokereval'

require 'poker_player/version'
require 'poker_player/constants'
require 'poker_player/deck'
require 'poker_player/calculations'
require 'poker_player/log'

module PokerPlayer

  BET_WITH_RANDOM = true

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
    amount_to_call = highest_bet - current_bet
    ideal_bet = self.send("#{stage}_ideal_bet_amount".to_sym,hole_cards, board_cards, current_player['bank_roll'])
    
    if amount_to_call > 0
      if ideal_bet > highest_bet
        bet(ideal_bet - current_bet)
      elsif ideal_bet == highest_bet
        call
      else
        fold
      end
    else
      if ideal_bet > current_bet
        bet(ideal_bet - current_bet)
      else
        call
      end
    end

	end

  private

  #
  # GAME MOVES 
  #
  def self.bet(amount)
    return call if amount == 0
    
    if BET_WITH_RANDOM
      r = rand
      if r > 0.70
        new_amount = rand(70)
        amount = new_amount if new_amount > amount
        ['bet', amount.to_i]
      else
        ['bet', amount.to_i]
      end
    else
      ['bet', amount.to_i]
    end
  end

  def self.call
    if BET_WITH_RANDOM
      r = rand
      if r > 0.70
        bet(rand(20).to_i)
      else
        ['call']
      end
    else
      ['call']
    end
  end

  def self.fold
    if BET_WITH_RANDOM
      r = rand
      if r > 0.80
        bet(rand(10).to_i)
      elsif r > 0.75
        call
      else
        ['fold']
      end
    else
      ['fold']
    end
  end

  #
  # HELPER METHODS
  #
  def self.random_move(moves)
    sum = 0
    moves.each { |prob,m| sum += prob }
    raise ArgumentError, "The probabilities must add up to 1.0" if sum != 1.0
  end

  def self.highest_bet(game_state)
    player = game_state['players'].max_by{|p| p['current_bet'] }
    return player['current_bet']
  end

  def self.highest_bet_player_id(game_state)
    player = game_state['players'].max_by{|p| p['current_bet'] }
    return player['id']
  end

  #
  # IDEAL BET AMOUNT
  #
  def self.pre_flop_ideal_bet_amount(hole_cards, board_cards, bank_roll)
    group = Calculations.sklansky_group(hole_cards.join)
    return case group
      when 1 then bank_roll * 0.20
      when 2 then bank_roll * 0.18    
      when 3 then bank_roll * 0.16  
      when 4 then bank_roll * 0.14
      when 5 then bank_roll * 0.12
      when 6 then bank_roll * 0.10
      when 7 then bank_roll * 0.08
      when 8 then bank_roll * 0.06       
      else 0        
    end    
  end

  def self.flop_ideal_bet_amount(hole_cards, board_cards, bank_roll)
    ehs = Calculations.effective_hand_strength(hole_cards.join, board_cards.join)
    bet_multiplier = 0.2

    if ehs > 0.5
      return bank_roll * ehs * bet_multiplier
    else
      return 0
    end
  end
  
  def self.turn_ideal_bet_amount(hole_cards, board_cards, bank_roll)
    flop_ideal_bet_amount(hole_cards, board_cards, bank_roll)
  end

  def self.river_ideal_bet_amount(hole_cards, board_cards, bank_roll)
    hs = Calculations.hand_strength(hole_cards.join, board_cards.join)
    bet_multiplier = 0.4
    if hs > 0.5
      return bank_roll * hs * bet_multiplier
    else
      return 0
    end    
  end

end
