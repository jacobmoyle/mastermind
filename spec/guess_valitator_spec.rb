require_relative '../lib/guess_validator'

describe GuessValidator do
  new_code = "ABCD"
  subject { GuessValidator.new(new_code) }

  describe '#unsolved_code' do
    # This seems like a code smell
    it 'responds to method call (readable)' do
      expect(subject).to respond_to(:unsolved_code)
    end
    it 'is writeable' do
      old_code = subject.unsolved_code
      subject.unsolved_code = "1234"
      expect(subject.unsolved_code).to_not eq(old_code)
    end
  end

  describe '#validate' do
    it 'responds to the method with param' do
      expect(subject).to respond_to(:validate).with(1).argument
    end
    context 'when guess is correct' do
      it 'responds with true' do
        expect(subject.validate("ABCD")).to eq(true)
      end
    end
  end

end