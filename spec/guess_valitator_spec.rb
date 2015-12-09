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
    {
      'a234'     => 'o',
      'A234'     => 'o',
      'ABCD'     => 'oooo',
      '1234'     => '',
      'A234'     => 'o',
      '1B34'     => 'o',
      '12C4'     => 'o',
      '123D'     => 'o',
      '1A34'     => 'x',
      'B234'     => 'x',
      '123C'     => 'x',
      '1D34'     => 'x',
      '12345667' => 'Guess too long',
      '1'        => 'Guess too short',

    }.each_pair do |code, expected_feedback|
      it "reponds to #{code} with #{expected_feedback}" do
        expect(feedback_for(code)).to eq(expected_feedback)
      end
    end

  end

end

# Helper Methods
def feedback_for(guess)
  subject.validate(guess)
end
