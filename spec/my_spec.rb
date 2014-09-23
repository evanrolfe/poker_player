require 'spec_helper'

describe PokerPlayer do
  it 'should return correct version string' do
  	game_json = load_game('flop_1')
    res = PokerPlayer.get_move(game_json)
    puts "RESULT: #{res}"
  end
end
