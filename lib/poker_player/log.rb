module PokerPlayer
  module Log

    LOG_PATH = '/home/evan/Code/Poker/poker_player/logs'

    def self.write(msg)
      open("#{LOG_PATH}/log.txt", 'a') do |f|
        f.puts "#{Time.now.strftime("%F %H:%M")} - #{msg}"
      end
    end

  end
end
