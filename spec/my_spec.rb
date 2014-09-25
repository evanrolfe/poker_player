require 'spec_helper'

describe PokerPlayer do
  it 'PRE FLOP GAME 1' do
  	game_json = load_game('pre_flop_1')
    move = PokerPlayer.get_move(game_json)
    expect(move).to eq(['bet',2])
  end

  it 'PRE FLOP GAME 2' do
    game_json = load_game('pre_flop_2')
    allow(PokerPlayer::Utils).to receive(:chen_formula).and_return(9)
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('call')
  end  

  it 'PRE FLOP GAME 3' do
    game_json = load_game('pre_flop_3')
    allow(PokerPlayer::Utils).to receive(:chen_formula).and_return(9)
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('fold')
  end

  it 'FLOP GAME 1' do
    game_json = load_game('flop_1')
    allow(PokerPlayer::Utils).to receive(:effective_hand_strength).and_return(0.3215700698758919)
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('fold')
  end

  it 'FLOP GAME 2' do
    game_json = load_game('flop_2')
    allow(PokerPlayer::Utils).to receive(:effective_hand_strength).and_return(0.8985376471704533)
    move = PokerPlayer.get_move(game_json)
    expect(move).to eq(['bet',6])
  end         

  it 'TURN GAME 1' do
    game_json = load_game('turn_1')
    allow(PokerPlayer::Utils).to receive(:effective_hand_strength).and_return(0.89)
    move = PokerPlayer.get_move(game_json)
    expect(move.first).to eq('call')
  end  

  it 'RIVER GAME 1' do
    game_json = load_game('river_1')
    allow(PokerPlayer::Utils).to receive(:effective_hand_strength).and_return(0.89)
    move = PokerPlayer.get_move(game_json)
    puts move
  end  
end
