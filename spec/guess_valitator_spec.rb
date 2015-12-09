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
    context 'Code to be solved is "ABCD"' do
      abcd = GuessValidator.new("ABCD")
      {
        '1234'     => '',
        '12345667' => 'Guess length is incorrect, code is 4 characters',
        '1'        => 'Guess length is incorrect, code is 4 characters',
        ''         => 'Guess length is incorrect, code is 4 characters',
        'ABCD'     => 'oooo',
        'Abc4'     => 'ooo',
        'a23d'     => 'oo',
        'A234'     => 'o',
        '1B34'     => 'o',
        '12C4'     => 'o',
        '123D'     => 'o',
        'a2aa'     => 'o',
        'dabc'     => 'xxxx',
        '1abc'     => 'xxx',
        'da23'     => 'xx',
        '1A34'     => 'x',
        'B234'     => 'x',
        '123C'     => 'x',
        '1D34'     => 'x',
        '1aaa'     => 'x',
      }.each_pair do |guess, expected_feedback|
        it "reponds to #{guess} with #{expected_feedback}" do
          expect(feedback_for(abcd, guess)).to eq(expected_feedback)
        end
      end
    end

    context 'Code to be solved is "AABB"' do
      aabb = GuessValidator.new("AABB")
      {
        'baaa' => 'xox',
      }.each_pair do |guess, expected_feedback|
        it "reponds to #{guess} with #{expected_feedback}" do
          expect(feedback_for(aabb, guess)).to eq(expected_feedback)
        end
      end
    end
  end

end

# Helper Methods
def feedback_for(validator, guess)
  validator.validate(guess)
end
