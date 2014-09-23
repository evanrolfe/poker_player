require 'java'
java_import 'jpoker.Card'
java_import 'jpoker.Deck'
java_import 'jpoker.Hand'
java_import 'jpoker.Heuristics'

#ARGUMENTS: first two cards are hole cards, remaining cards are board cards
#EXAMPLE: jruby hand_potential.rb 2d 3c Td 9c Kd Kc; hole cards are: 2d 3c
ARGV.reverse!
board_cards = ARGV
hole_cards = []
hole_cards << board_cards.pop
hole_cards << board_cards.pop

offset = 5 - board_cards.count

potential = Hand::handPotential(hole_cards.join, board_cards.join, offset)
ppot = potential[0]
npot = potential[1]

puts "{\"ppot\": #{ppot}, \"npot\": #{npot}}"
