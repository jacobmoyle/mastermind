require_relative 'spec_helper'

describe CodeGenerator do

  describe '#generate' do
    it 'returns a string' do
      expect(subject.generate.class).to be(String)
    end
    it 'provides an output with four characters' do
      expect(subject.generate.length).to eq(4)
    end
    it 'does not output blank spaces' do
      expect(subject.generate.include?(" ")).not_to be(true)
    end

    it 'returns unique patterns 75% of the time' do
      patterns = patterns = 500.times.map{ subject.generate }
      expect(patterns.uniq.count / (patterns.count).to_f).to be >= 0.75
    end
  end
end
