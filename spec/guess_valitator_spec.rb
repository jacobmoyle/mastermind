require_relative '../lib/guess_validator'

describe GuessValidator do

  describe '#correct?' do

    it 'returns true if the guess and target match' do
      guess = GuessValidator.new(hidden_code: 'aaaa', guess: 'aaaa')
      expect(guess.correct?).to eq(true)
    end
    it 'returns false if the guess and target don\'t match' do
      guess = GuessValidator.new(hidden_code: 'aaaa', guess: 'bbbb')
      expect(guess.correct?).to eq(false)
    end
  end

  describe '#hint' do

    it 'is not case sensitive' do
      guess = GuessValidator.new(hidden_code: 'ABCD', guess: 'a2aF')
      expect(guess.hint).to eq('o')
    end
    it 'returns an empty string if the guess is completely wrong' do
      guess = GuessValidator.new(hidden_code: "ABCD", guess: '1234')
      expect(guess.hint).to eq('')
    end

    context 'when provided a correct character, incorrectly placed' do
      code = 'ABCD'

      it 'returns a double match if two characters are correct' do
        guess = GuessValidator.new(hidden_code: code, guess: 'da23')
        expect(guess.hint).to eq('xx')
      end
      it 'returns a triple match if three characters are correct' do
        guess = GuessValidator.new(hidden_code: code, guess: '1abc')
        expect(guess.hint).to eq('xxx')
      end
      it 'returns a quadruple match if four characters are correct' do
        guess = GuessValidator.new(hidden_code: code, guess: 'dabc')
        expect(guess.hint).to eq('xxxx')
      end
    end

    context 'when provided a correct character, but incorrect placement' do
      code = 'ABCD'

      it 'returns a single match if the guessed character is offset' do
        guess = GuessValidator.new(hidden_code: code, guess: 'B234')
        expect(guess.hint).to eq('x')

        guess = GuessValidator.new(hidden_code: code, guess: '123C')
        expect(guess.hint).to eq('x')

        guess = GuessValidator.new(hidden_code: code, guess: '1D34')
        expect(guess.hint).to eq('x')

        guess = GuessValidator.new(hidden_code: code, guess: '1A34')
        expect(guess.hint).to eq('x')

        guess = GuessValidator.new(hidden_code: code, guess: '1D34')
        expect(guess.hint).to eq('x')
      end
      it 'returns a single match when guess contains duplicates of a single digit' do
        guess = GuessValidator.new(hidden_code: code, guess: '1aaa')
        expect(guess.hint).to eq('x')
      end
    end

    context 'when provided a correct character, in the correct placement' do
      code = 'ABCD'

      it 'returns a single match if only the first character is correct' do
        guess = GuessValidator.new(hidden_code: code, guess: 'A234')
        expect(guess.hint).to eq('o')
      end
      it 'returns a single match if only the second character is correct' do
        guess = GuessValidator.new(hidden_code: code, guess: '1B34')
        expect(guess.hint).to eq('o')
      end
      it 'returns a single match if only the third character is correct' do
        guess = GuessValidator.new(hidden_code: code, guess: '12C4')
        expect(guess.hint).to eq('o')
      end
      it 'returns a single match if only the fourth character is correct' do
        guess = GuessValidator.new(hidden_code: code, guess: '123D')
        expect(guess.hint).to eq('o')
      end
      it 'returns a single match if there are duplicate characters in the guess, and only a single instance in target' do
        guess = GuessValidator.new(hidden_code: code, guess: 'a2aa')
        expect(guess.hint).to eq('o')
      end
    end

    context 'when provided with multiple correct characters, in the correct placement' do
      code = 'ABCD'

      it 'returns a double match if two characters are correct' do
        guess = GuessValidator.new(hidden_code: code, guess: 'a23d')
        expect(guess.hint).to eq('oo')
      end
      it 'returns a triple match if three characters are correct' do
        guess = GuessValidator.new(hidden_code: code, guess: 'Abc4')
        expect(guess.hint).to eq('ooo')
      end
      it 'returns a quadruple match if four characters are correct' do
        guess = GuessValidator.new(hidden_code: code, guess: 'ABCD')
        expect(guess.hint).to eq('oooo')
      end
    end

    context 'when the guessed code has duplicate characters' do
      code = "AABB"

      it 'only counts the guessed characters once' do
        guess = GuessValidator.new(hidden_code: code, guess: 'baaa')
        expect(guess.hint).to eq('xox')
      end
    end

  end
end
