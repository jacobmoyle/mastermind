require_relative '../lib/guess_validator'

describe GuessValidator do
  it { should respond_to(:winning_response) }
  it { should respond_to(:validate) }

  describe '#validate' do

    it 'is not case sensitive' do
      expect(feedback_for('ABCD', 'a2aF')).to eq('o')
    end

    it 'returns an empty string if the guess is completely wrong' do
      code = "ABCD"

      expect(feedback_for(code, '1234')).to eq('')
    end

    context 'when input is invalid' do
      code = "ABCD"

      it 'returns an error if the guess is too long' do
        expect(feedback_for(code, '12345667').length).to be > 0
      end
      it 'returns an error if the guess is too short' do
        expect(feedback_for(code, '1').length).to be > 0
      end
      it 'returns an error if the guess is an empty string' do
        expect(feedback_for(code, '').length).to be > 0
      end
    end

    context 'when provided a correct character, but incorrect placement' do
      code = 'ABCD'

      it 'returns a double match if two characters are correct' do
        expect(feedback_for(code, 'da23')).to eq('xx')
      end
      it 'returns a triple match if three characters are correct' do
        expect(feedback_for(code, '1abc')).to eq('xxx')
      end
      it 'returns a quadruple match if four characters are correct' do
        expect(feedback_for(code, 'dabc')).to eq('xxxx')
      end
    end

    context 'when provided a correct character, but incorrect placement' do
      code = 'ABCD'

      it 'returns a single match if the guessed character is offset' do
        expect(feedback_for(code, 'B234')).to eq('x')
        expect(feedback_for(code, '123C')).to eq('x')
        expect(feedback_for(code, '1D34')).to eq('x')
        expect(feedback_for(code, '1A34')).to eq('x')
        expect(feedback_for(code, '1D34')).to eq('x')
      end
      it 'returns a single match when the guess contains multiple duplicates of a single digit' do
        expect(feedback_for(code, '1aaa')).to eq('x')
      end
    end

    context 'when provided a correct character, in the correct placement' do
      code = 'ABCD'

      it 'returns a single match if only the first character is correct' do
        expect(feedback_for(code, 'A234')).to eq('o')
      end
      it 'returns a single match if only the second character is correct' do
        expect(feedback_for(code, '1B34')).to eq('o')
      end
      it 'returns a single match if only the third character is correct' do
        expect(feedback_for(code, '12C4')).to eq('o')
      end
      it 'returns a single match if only the fourth character is correct' do
        expect(feedback_for(code, '123D')).to eq('o')
      end
      it 'returns a single match if there are duplicate characters in the guess, and only a single instance in target' do
        expect(feedback_for(code, 'a2aa')).to eq('o')
      end
    end

    context 'when provided with multiple correct characters, in the correct placement' do
      code = 'ABCD'

      it 'returns a double match if two characters are correct' do
        expect(feedback_for(code, 'a23d')).to eq('oo')
      end
      it 'returns a triple match if three characters are correct' do
        expect(feedback_for(code, 'Abc4')).to eq('ooo')
      end
      it 'returns a quadruple match if four characters are correct' do
        expect(feedback_for(code, 'ABCD')).to eq('oooo')
      end
    end

    context 'when the guessed code has duplicate characters' do
      code = "AABB"

      it 'only counts the guessed characters once' do
        expect(feedback_for(code, 'baaa')).to eq('xox')
      end
    end

  end
end

# Helper Methods
def feedback_for(unsolved_code, guess)
  subject.validate(unsolved_code, guess)
end
