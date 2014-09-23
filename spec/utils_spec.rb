require 'spec_helper'

describe PokerPlayer::Utils do

  describe '#chen_formula' do
    xit { expect(PokerPlayer::Utils.chen_formula('Ad Ac')).to eq(20) }
  end

  describe '#hand_potentential' do
    context 'on the flop' do
      subject{ PokerPlayer::Utils.hand_potential('2d 3c', 'Td 9c Kd') }
      it do
          expect(subject['ppot'].round(2)).to eq(0.13)
          expect(subject['npot'].round(2)).to eq(0.76)
        end
      end
    context 'on the turn' do
      subject{ PokerPlayer::Utils.hand_potential('2d 3c', 'Td 9c Kd 3d') }
      it do
        expect(subject['ppot'].round(2)).to eq(0.28)
        expect(subject['npot'].round(2)).to eq(0.72)
      end
    end
  end

  describe '#hand_strength' do
    xit { expect(PokerPlayer::Utils.hand_strength('2d 3c', 'Td 9c Kd Kc 6c')).to eq(0.0353535353535353) }
  end

end
