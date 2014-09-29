require 'spec_helper'

describe PokerPlayer do
  it 'PRE FLOP GAME 1' do
  	game_json = load_game('pre_flop_1')
    move = PokerPlayer.get_move(game_json)
    expect(move).to eq(['bet',6])
  end

  it 'PRE FLOP GAME 2' do
    game_json = load_game('pre_flop_2')
    move = PokerPlayer.get_move(game_json)
    expect(move).to eq(['bet', 4])
  end  

  it 'PRE FLOP GAME 3' do
    game_json = load_game('pre_flop_3')
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('fold')
  end

  it 'PRE FLOP GAME 4' do
    game_json = load_game('pre_flop_4')
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('call')
  end

  it 'FLOP GAME 1' do
    game_json = load_game('flop_1')
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('fold')
  end

  it 'FLOP GAME 2' do
    game_json = load_game('flop_2')
    move = PokerPlayer.get_move(game_json)
    expect(move).to eq(['bet', 14])
  end         

  it 'TURN GAME 1' do
    game_json = load_game('turn_1')
    move = PokerPlayer.get_move(game_json)
    expect(move).to eq(['bet', 11])
  end  

  it 'RIVER GAME 1' do
    game_json = load_game('river_1')
    move = PokerPlayer.get_move(game_json)
    puts move
  end  

end
