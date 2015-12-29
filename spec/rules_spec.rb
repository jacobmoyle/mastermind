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

    it 'defaults to 9 upon initialization' do
      new_rules = Rules.new
      expect(new_rules.turns).to eq(9)
    end
  end

  describe '#turn_over' do

    it 'turns decrease by one each time #turn_over is run' do
      new_rules = Rules.new
      count = 9

      9.times do
        expect(new_rules.turns).to eq(count)
        count -= 1
        new_rules.turn_over
      end
    end

    context 'when turns remain' do
      it 'should not raise' do
        expect { subject.turn_over }.to_not raise_error
      end
    end

    it 'should raise an error when zero turns remain' do
      new_rules = Rules.new
      expect {

        until new_rules.turns == 0
          subject.turn_over
        end

      }.to raise_error
    end
  end
end