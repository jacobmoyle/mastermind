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

  describe '#turn_over' do
    context 'when turns remain' do
      it 'should not raise' do
        expect { subject.turn_over }.to_not raise_error
      end
    end
    context 'when ten turns have been made' do
      it 'should raise an error' do
        expect { 10.times { subject.turn_over } }.to raise_error
      end
    end
  end
end