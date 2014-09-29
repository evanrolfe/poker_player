require 'spec_helper'

describe PokerPlayer do
  it 'ensures that the probabilities add up to 1.0' do
    dist = {0.99 => 'bet'}
    expect{ PokerPlayer.random_move(dist) }.to raise_error(ArgumentError)
    dist = {0.5 => 'bet', 0.2 => 'call', 0.3 => 'fold'}
    expect{ PokerPlayer.random_move(dist) }.not_to raise_error
    dist = {1.0 => 'bet'}
    expect{ PokerPlayer.random_move(dist) }.not_to raise_error    
  end
end
