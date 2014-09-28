require 'spec_helper'

describe PokerPlayer::Calculations do

  describe '#hand_potential' do
    it do
      (ppot, npot) = PokerPlayer::Calculations.hand_potential("2h3h", "4h5h9c")
      expect(ppot).to be > 0.3
    end    

    it do
      (ppot, npot) = PokerPlayer::Calculations.hand_potential("Td5s", "4h5h9c")
      expect(npot).to be > 0.1
    end
  end

  describe '#sklansky_rank' do
    it { expect(PokerPlayer::Calculations.sklansky_group("AsAc")).to eq(1) }
    it { expect(PokerPlayer::Calculations.sklansky_group("2s7c")).to eq(8) }
    it { expect(PokerPlayer::Calculations.sklansky_group("9sTs")).to eq(4) }
  end

  describe '#effective_hand_strength' do
    it { expect(PokerPlayer::Calculations.effective_hand_strength("2h3h", "4h5h9c").round(2)).to eq(0.38) }
    it { expect(PokerPlayer::Calculations.effective_hand_strength("Td5s", "4h5h9c").round(2)).to eq(0.81) }
  end

  describe '#hand_strength' do
    it { expect(PokerPlayer::Calculations.hand_strength("Td5s", "4h5h9c").round(2)).to eq(0.79) }
    it { expect(PokerPlayer::Calculations.hand_strength("Td5s", "4h5h9cTs").round(2)).to eq(0.98) }
    it { expect(PokerPlayer::Calculations.hand_strength("2d5s", "4h5h9cTs3d").round(2)).to eq(0.58) }
  end

end
