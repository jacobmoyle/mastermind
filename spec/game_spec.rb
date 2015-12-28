require_relative '../lib/game'
require_relative '../lib/rules'

describe Game do
  let(:rules) {
    Rules.new
       }
  let(:player) {
    double('input')
  }
  let(:code_maker) {
    double('code')
  }
  let(:validator) {
    double('feedback')
  }
  let(:output) {
    double('view',
      greeting: 'hi',
      guess_prompt: 'input something',
      round_feedback: 'things happened',
      goodbye: 'fin'
    )}
  let(:game) {
      Game.new(
        input: player,
        code_maker: code_maker,
        code_checker: validator,
        view: output,
        game_rules: rules
    )}


  describe '#start' do

    before do
      allow(validator).to receive(:new).with(any_args).and_return(validator)
    end

    context 'first guess is correct' do

      before do
        allow(validator).to receive(:hint).and_return(String.new)
        allow(player).to receive(:guess).and_return('abcd')
        allow(code_maker).to receive(:generate).and_return('abcd')
        allow(validator).to receive(:correct?).and_return(true)
      end

      it 'stops prompting the player after a correct guess' do
        expect(player).to receive(:guess).once
        game.start
      end
      it 'notifies the player the game has begun' do
        expect(output).to receive(:greeting)
        game.start
      end

      it 'notifies the player the game has ended' do
        expect(output).to receive(:goodbye)
        game.start
      end
    end

    context 'player is right on the 10th guess' do

      before do
        allow(player).to receive(:guess).and_return('aaaa','bbbb',
          'cccc','dddd','eeee','abcd','aacc','eeff','bcde','ffff')
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(validator).to receive(:hint).and_return(
          'one','two','three','four','five','six','seven','eight',
          'nine','right')
        allow(validator).to receive(:correct?).and_return(false,false,
          false,false,false,false,false,false,false,true)
      end

      it 'prompts a player ten times' do
        expect(player).to receive(:guess).exactly(10).times
        game.start
      end

      it 'provides a new hint, specific to each guess' do
        expect(output).to receive(:round_feedback).with(any_args, 'one')
        expect(output).to receive(:round_feedback).with(any_args, 'two')
        expect(output).to receive(:round_feedback).with(any_args, 'three')
        expect(output).to receive(:round_feedback).with(any_args, 'four')
        expect(output).to receive(:round_feedback).with(any_args, 'five')
        expect(output).to receive(:round_feedback).with(any_args, 'six')
        expect(output).to receive(:round_feedback).with(any_args, 'seven')
        expect(output).to receive(:round_feedback).with(any_args, 'eight')
        expect(output).to receive(:round_feedback).with(any_args, 'nine')
        expect(output).to receive(:round_feedback).with(any_args, 'right')

        game.start
      end
    end

    context 'player is never right' do

      before do
        allow(player).to receive(:guess).and_return('aaaa')
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(validator).to receive(:correct?).and_return(false)
      end

      it 'it prompts a player ten times' do
        expect(player).to receive(:guess).exactly(10).times
        game.start
      end
    end
  end
end

