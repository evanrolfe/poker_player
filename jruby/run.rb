require 'java'
java_import 'jpoker.Card'
java_import 'jpoker.Deck'
java_import 'jpoker.Hand'
java_import 'jpoker.Heuristics'

VERBOSE = false

ARGV.reverse!
pot = ARGV.pop  #First argument is the pot total
amount_to_call = ARGV.pop   #Second is the amount to call
current_bet = ARGV.pop  #Third is this players current amount bet

#4rth and 5th arguments are the hole cards
board_cards = ARGV
hole_cards = []
hole_cards << board_cards.pop
hole_cards << board_cards.pop

#The rest are the board cards
puts "Hole Cards:"  if VERBOSE
puts hole_cards     if VERBOSE
puts "Board Cards:" if VERBOSE
puts board_cards    if VERBOSE

def effective_hand_score(hs, ppot, npot)
  hs + ((1-hs) * ppot)
end

def pot_odds(amount_to_call, pot)
  amount_to_call.to_f / (amount_to_call.to_f + pot.to_f)
end

def rate_of_return(ehs, pot_odds)
  ehs.to_f / pot_odds.to_f
end

def raise_amount(ehs, pot, desired_rr)
  pot = pot.to_f
  ehs = ehs.to_f
  (ehs * pot) / (desired_rr - pot)
end

#-----------------------------------------------
#   PRE FLOP
#-----------------------------------------------
if board_cards.length == 0
  chen = Heuristics::ChenFormula(hole_cards.join)
  chance = chen/20

#-----------------------------------------------
#   FLOP
#-----------------------------------------------
elsif board_cards.length == 3
  hs = Hand::handStrength(hole_cards.join, board_cards.join)
  potential = Hand::handPotential(hole_cards.join, board_cards.join, 2)
  ppot = potential[0]
  npot = potential[1]
  chance = effective_hand_score(hs, ppot, npot)

#-----------------------------------------------
#   TURN
#-----------------------------------------------
elsif board_cards.length == 4
  hs = Hand::handStrength(hole_cards.join, board_cards.join)
  potential = Hand::handPotential(hole_cards.join, board_cards.join, 1)
  ppot = potential[0]
  npot = potential[1]
  chance = effective_hand_score(hs, ppot, npot)

#-----------------------------------------------
#   RIVER
#-----------------------------------------------
elsif board_cards.length == 5
  hs = Hand::handStrength(hole_cards.join, board_cards.join)
  chance = hs
end

pot_odds = pot_odds(amount_to_call, pot)
rr = rate_of_return(chance, pot_odds)

puts "Chance of winning: #{chance}"   if VERBOSE
puts "Pot odds: #{pot_odds}"          if VERBOSE
puts "Rate of return: #{rr}"          if VERBOSE

if board_cards.length == 0    #Pre flop

  if chance >= 0.1
    puts "call,"
  else
    puts "fold,"
  end

else

  if rr > 0.5
    bet = raise_amount(chance, pot, 0.5)

    if bet.to_i < amount_to_call.to_i     #Must raise by at least the amount to call
      puts "fold,"
    else
      puts "bet,#{bet.to_i}"
    end
  elsif rr <= 0.5 && rr > 0.2
    puts "call,"
  elsif rr <= 0.2
    puts "fold,"
  end

end
