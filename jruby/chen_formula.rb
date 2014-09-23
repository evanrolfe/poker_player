require 'java'
java_import 'jpoker.Card'
java_import 'jpoker.Deck'
java_import 'jpoker.Hand'
java_import 'jpoker.Heuristics'

#ARGUMENTS: first two cards are hole cards, remaining cards are board cards
#EXAMPLE: jruby chen_formula.rb 2d 3c; hole cards are: 2d 3c
ARGV.reverse!
board_cards = ARGV
hole_cards = []
hole_cards << board_cards.pop
hole_cards << board_cards.pop

chen = Heuristics::ChenFormula(hole_cards.join)

puts "{\"ranking\": #{chen}}"
