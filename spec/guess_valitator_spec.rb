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

    it 'responds with an error if input is too long' do
      expect(error_for('12345667')).to_not eq(nil)
      expect(error_for('1')).to_not eq(nil)
    end

    it 'responds to the method with param' do
      expect(subject).to respond_to(:validate).with(1).argument
    end

    it 'can accept uppercase or lowercase input' do
      expect(feedback_for('a234')).to eq('o')
      expect(feedback_for('A234')).to eq('o')
    end

    context 'when guess is completely correct' do
      it 'responds with true' do
        expect(feedback_for('ABCD')).to eq('oooo')
      end
    end

    context 'when guess is incorrect' do

      it 'responds with false if completely incorrect' do
        expect(feedback_for('1234')).to eq('')
      end

      it 'provides o for any correct character in the correct spot' do
        expect(feedback_for('A234')).to eq('o')
        expect(feedback_for('1B34')).to eq('o')
        expect(feedback_for('12C4')).to eq('o')
        expect(feedback_for('123D')).to eq('o')
      end

      # No tests written to cover duplicate characters
      it 'provides x if a character is correct but in the incorrect spot' do
        expect(feedback_for('1A34')).to eq('x')
        expect(feedback_for('B234')).to eq('x')
        expect(feedback_for('123C')).to eq('x')
        expect(feedback_for('1D34')).to eq('x')
      end
    end
  end
end

# Helper Methods
def feedback_for(guess)
  subject.validate(guess).feedback
end

def error_for(guess)
  subject.validate(guess).error
end