require_relative '../lib/rules'

describe Rules do
  describe '#valid_guess?' do
    it 'returns true if the input is 4 characters long' do
      expect(subject.valid_guess?('cccc')).to eq(true)
    end
    it 'it returns false if the input is greater than 4' do
      expect(subject.valid_guess?('caaac')).to eq(false)
    end
    it 'returns false if the input is less than 4' do
      expect(subject.valid_guess?('cac')).to eq(false)
    end
    it 'returns true if the input contains a' do
      expect(subject.valid_guess?('caaac')).to eq(false)
    end
    xit 'b, etc.' do
    end
    xit 'returns false if the input contains anything outside of the specified characters above (flush this description out)' do
    end
  end
end