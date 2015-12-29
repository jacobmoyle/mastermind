require_relative '../lib/rules'

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

  describe '#turn_over' do
    it 'when turns remain should not raise an error' do
      expect { subject.turn_over }.to_not raise_error
    end
    it 'should raise an error when zero turns remain' do
      new_rules = Rules.new
      expect {
        until new_rules.turns == 0
          subject.turn_over
        end
      }.to raise_error
    end
    it 'turns decrease by one each time #turn_over is run' do
      new_rules = Rules.new
      count = 10

      9.times {
        expect(new_rules.turns).to eq(count)
        count -= 1
        new_rules.turn_over
      }
    end
  end

  describe '#game_over?' do
    context 'when guess is incorrect' do
      it 'returns false if turns remain' do
        guess = double('guess')
        allow(guess).to receive(:correct?).and_return(false)
        new_rules = Rules.new
        9.times {
          new_rules.turn_over
          expect(new_rules.game_over?(guess)).to eq(false)
        }
      end
      it 'returns true when no turns remain' do
        guess = double('guess')
        allow(guess).to receive(:correct?).and_return(false)
        new_rules = Rules.new
        10.times {
          new_rules.turn_over
        }
        expect(new_rules.game_over?(guess)).to eq(true)
      end
    end

    context 'when guess is correct' do
      it 'returns true when there are turns left' do
        guess = double('guess')
        allow(guess).to receive(:correct?).and_return(true)
        new_rules = Rules.new
        expect(new_rules.game_over?(guess)).to eq(true)
      end
    end
  end

end
