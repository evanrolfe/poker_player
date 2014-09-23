require 'java'
java_import 'jpoker.Card'
java_import 'jpoker.Deck'
java_import 'jpoker.Hand'
java_import 'jpoker.Heuristics'

#ARGUMENTS: first two cards are hole cards, remaining cards are board cards
#EXAMPLE: jruby hand_strength.rb 2d 3c Td 9c Kd Kc 6c; hole cards are: 2d 3c
ARGV.reverse!
board_cards = ARGV
hole_cards = []
hole_cards << board_cards.pop
hole_cards << board_cards.pop

hand_strength = Hand::handStrength(hole_cards.join, board_cards.join)

puts "{\"hand_strength\": #{hand_strength}}"
