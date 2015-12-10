require_relative '../lib/guess_validator'

describe GuessValidator do
  describe '#validate' do
    context 'Code to be solved is "ABCD"' do
      code = "ABCD"
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
          expect(feedback_for(code, guess)).to eq(expected_feedback)
        end
      end
    end

    context 'Code to be solved is "AABB"' do
      code = "AABB"
      {
        'baaa' => 'oxx',
      }.each_pair do |guess, expected_feedback|
        it "reponds to #{guess} with #{expected_feedback}" do
          expect(feedback_for(code, guess)).to eq(expected_feedback)
        end
      end
    end
  end

end

# Helper Methods
def feedback_for(unsolved_code, guess)
  subject.validate(unsolved_code, guess)
end
