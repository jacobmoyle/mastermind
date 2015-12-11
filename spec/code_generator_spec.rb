require_relative '../lib/code_generator'

describe CodeGenerator do

  describe '#generate' do
    it 'returns a string' do
      expect(subject.generate.class).to be(String)
    end
    it 'provides an output with four characters' do
      expect(subject.generate.length == 4).to be(true)
    end
    it 'does not output blank spaces' do
      expect(subject.generate.include?(" ")).to be(false)
    end

    it 'returns unique patterns 75% of the time' do
      patterns = []
      500.times do
        patterns << subject.generate
      end
      expect(patterns.uniq.count / (patterns.count).to_f).to be >= 0.75
    end
  end
end
