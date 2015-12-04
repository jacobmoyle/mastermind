require_relative '../lib/guess_validator'
require_relative '../lib/code_generator'

describe GuessValidator do
  code = CodeGenerator.new.generate
  subject { GuessValidator.new(code) }

  describe '#unsolved_code' do
    # This seems like a code smell
    it 'responds to method call (readable)' do
      expect(subject).to respond_to(:unsolved_code)
    end
    # Is there a concise way to avoid an RNG failure?
    it 'is writeable - run test twice in case of RNG failure' do
      old_code = subject.unsolved_code
      subject.unsolved_code = "1234"
      expect(subject.unsolved_code).to_not eq(old_code)
    end
  end
end