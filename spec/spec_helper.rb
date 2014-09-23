require 'rspec'
require 'rspec/its'
require 'pry'
require 'poker_player'

PRESET_GAMES_PATH = '/home/evan/Code/Poker/poker_player/spec/preset_games/'

def load_game(file_name)
	File.read("#{PRESET_GAMES_PATH}#{file_name}.json")
end

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end
