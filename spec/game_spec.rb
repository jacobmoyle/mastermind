require_relative 'spec_helper'

describe Game do
  let(:rules) {
    double('rules')
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
  let(:output) { View.new
  #   double('view',
  #     greeting: 'hi',
  #     guess_prompt: 'input something',
  #     round_feedback: 'things happened',
  #     goodbye: 'fin'
  # )
}
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
      allow(rules).to receive(:subtract_turn).with(no_args)
      allow(rules).to receive(:turns).with(no_args).and_return(9,8,7,6,5,4,3,2,1)
      allow(rules).to receive(:valid_guess?).with(an_instance_of(String)).and_return(true)
    end

    context 'when input is incorrect' do

      before do
        allow(rules).to receive(:valid_guess?).with(an_instance_of(String)).and_return(false,false,false,true)
        allow(rules).to receive(:game_over?).and_return(true)
        allow(validator).to receive(:hint).and_return('correct')
        allow(player).to receive(:guess).and_return('1234','zzssw','','abcd')
        allow(code_maker).to receive(:generate).and_return('abcd')
        allow(validator).to receive(:correct?).and_return(true)
      end

      it 'will repeatedly inform user input is invalid until valid input is supplied' do
        expect(output).to receive(:guess_invalid).exactly(3).times
        game.start
      end
    end

    context 'first guess is correct' do

      before do
        allow(rules).to receive(:game_over?).and_return(true)
        allow(validator).to receive(:hint).and_return('correct')
        allow(player).to receive(:guess).and_return('abcd')
        allow(code_maker).to receive(:generate).and_return('abcd')
        allow(validator).to receive(:correct?).and_return(true)
      end

      it "outputs '9' turns remaining and 'correct' for feedback" do
        expect(output).to receive(:round_feedback).with(9, 'correct').once
        game.start
      end
      it 'checks if guess is correct once' do
        expect(validator).to receive(:correct?).once
        game.start
      end
      it 'stops prompting the player after a correct guess' do
        expect(player).to receive(:guess).once
        game.start
      end
      it 'notifies the player the game has begun' do
        expect(output).to receive(:greeting).once
        game.start
      end
      it 'notifies the player the game has ended' do
        expect(output).to receive(:goodbye).once
        game.start
      end
      it 'notifies the player the game has started before notifying it is over' do
        expect(output).to receive(:greeting).ordered
        expect(output).to receive(:goodbye).ordered
        game.start
      end
    end

    context 'player is never right' do

      before do
        allow(rules).to receive(:game_over?).and_return(
          false,false,false,false,false,false,false,false,false,true)
        allow(validator).to receive(:hint).and_return('incorrect')
        allow(player).to receive(:guess).and_return('aaaa')
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(validator).to receive(:correct?).and_return(false)
      end

      it 'outputs the current turn and new feedback specific to each guess' do
        expect(output).to receive(:round_feedback).with(9, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(8, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(7, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(6, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(5, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(4, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(3, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(2, 'incorrect').ordered
        expect(output).to receive(:round_feedback).with(1, 'incorrect').ordered

        game.start
      end
      it 'generates a hint ten times' do
        expect(validator).to receive(:hint).exactly(10).times
        game.start
      end
      it 'stops prompting the player after all guesses are used' do
        expect(player).to receive(:guess).exactly(10).times
        game.start
      end
      it 'checks if guess is correct ten times' do
        expect(validator).to receive(:correct?).exactly(10).times
        game.start
      end
      it 'reduces turns remaining nine times' do
        expect(rules).to receive(:subtract_turn).exactly(9).times
        game.start
      end
    end
  end
end
