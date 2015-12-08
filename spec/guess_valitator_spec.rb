require_relative '../lib/guess_validator'

describe GuessValidator do
  new_code = "ABCD"
  subject { GuessValidator.new(new_code) }

  describe '#unsolved_code' do
    it 'responds to method call (readable)' do
      expect(subject).to respond_to(:unsolved_code)
    end
  end

  describe '#set_code' do

    it 'changes the unsolved code' do
      validator = GuessValidator.new(new_code)
      previous_code = validator.unsolved_code
      validator.set_code("1234")

      expect(validator.unsolved_code).to_not eq(previous_code)
    end
  end

  describe '#validate' do

    it 'responds to the method with param' do
      expect(subject).to respond_to(:validate).with(1).argument
    end

    context 'when guess is completely correct' do
      it 'responds with true' do
        expect(subject.validate('ABCD')).to eq('oooo')
      end
    end

    context 'when guess is incorrect' do

      it 'responds with false if completely incorrect' do
        expect(subject.validate('1234')).to eq('')
      end

      it 'provides o for any correct character in the correct spot' do
        expect(subject.validate('A234')).to eq('o')
        expect(subject.validate('1B34')).to eq('o')
        expect(subject.validate('12C4')).to eq('o')
        expect(subject.validate('123D')).to eq('o')
      end

      # No tests written to cover duplicate characters
      it 'provides x if a character is correct but in the incorrect spot' do
        expect(subject.validate('1A34')).to eq('x')
        expect(subject.validate('B234')).to eq('x')
        expect(subject.validate('123C')).to eq('x')
        expect(subject.validate('1D34')).to eq('x')
      end
    end
  end

end