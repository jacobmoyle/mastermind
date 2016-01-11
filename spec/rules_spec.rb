require 'spec_helper'

describe Rules do
  describe '#valid_guess?' do
    context 'when using correct characters' do
      it 'returns true if the input is 4 characters long' do
        expect(subject.valid_guess?('cccc')).to eq(true)
      end
      it 'it returns false if the input is greater than 4' do
        expect(subject.valid_guess?('caaac')).to eq(false)
      end
      it 'returns false if the input is less than 4' do
        expect(subject.valid_guess?('cac')).to eq(false)
      end
      it 'it handles mixed case input' do
        expect(subject.valid_guess?('cCcC')).to eq(true)
      end
    end

    context 'when using incorrect characters' do
      it 'returns false if the input includes invalid characters at the length of 4' do
        expect(subject.valid_guess?('¬˚˜å')).to eq(false)
        expect(subject.valid_guess?('abqr')).to eq(false)
        expect(subject.valid_guess?('    ')).to eq(false)
      end
    end
  end

  describe '#turns' do
    it 'defaults to 10 upon initialization' do
      new_rules = Rules.new
      expect(new_rules.turns).to eq(10)
    end
  end

  describe '#subtract_turn' do
    it 'when turns remain should not raise an error' do
      expect { subject.subtract_turn }.to_not raise_error
    end
    it 'should raise an error when zero turns remain' do
      new_rules = Rules.new
      expect {
        until new_rules.turns == 0
          subject.subtract_turn
        end
      }.to raise_error
    end
    it 'turns decrease by one each time #subtract_turn is run' do
      new_rules = Rules.new
      count = 10

      9.times {
        expect(new_rules.turns).to eq(count)
        count -= 1
        new_rules.subtract_turn
      }
    end
  end

  describe '#game_over?' do
    context 'when guess is incorrect' do
      it 'returns false if turns remain' do
        new_rules = Rules.new
        9.times {
          new_rules.subtract_turn
          expect(new_rules.game_over?('oo')).to eq(false)
        }
      end
      it 'returns true when no turns remain' do
        new_rules = Rules.new
        10.times {
          new_rules.subtract_turn
        }
        expect(new_rules.game_over?('oo')).to eq(true)
      end
      it 'returns false when feedback contains too many "o"s' do
        expect(subject.game_over?('ooooo')).to eq(false)
      end
      it 'returns false when feedback contains too few "o"s' do
        expect(subject.game_over?('oo')).to eq(false)
      end
      it 'returns false when feedback four different characters' do
        expect(subject.game_over?('rabo')).to eq(false)
      end
    end

    context 'when guess is correct' do
      it 'returns true when there are turns left' do
        new_rules = Rules.new
        expect(new_rules.game_over?('oooo')).to eq(true)
      end
    end
  end

end
