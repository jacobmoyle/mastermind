require_relative '../lib/code_generator'

describe CodeGenerator do
  describe '#generate' do
    it 'provides an output with four characters' do
      expect(subject.generate.length == 4).to be(true)
    end
  end
end