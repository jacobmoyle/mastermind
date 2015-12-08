require_relative '../lib/code_generator'

describe CodeGenerator do

  describe '#generate' do
    # don't care about the type being output, just expect it to respond
    it 'returns a string' do
      expect(subject.generate.class).to be(String)
    end
    it 'provides an output with four characters' do
      expect(subject.generate.length == 4).to be(true)
    end
    it 'does not output blank spaces' do
      expect(subject.generate.include?(" ")).to be(false)
    end
    # Create a test to make sure the characters in the pool are correct. It's safe to test this because the characters are in the spec, rather than unknown
    it 'returns unique patterns 75% of the time' do
      patterns = []
      500.times do
        patterns << subject.generate
      end
      expect(patterns.uniq.count / (patterns.count).to_f).to be >= 0.75
    end
  end
end
