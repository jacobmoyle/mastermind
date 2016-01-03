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

    context 'player is right on the 10th guess' do

      before do
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(player).to receive(:guess).and_return(
          'aaaa','bbbb','cccc','dddd','eeee','abcd','aacc','eeff','bcde','ffff')
        allow(validator).to receive(:hint).and_return(
          'one','two','three','four','five','six','seven','eight','nine','right')
        allow(validator).to receive(:correct?).and_return(
          false,false,false,false,false,false,false,false,false,true)
      end

      it 'outputs the current turn and new feedback specific to each guess' do
        expect(output).to receive(:round_feedback).with(9, 'one').ordered
        expect(output).to receive(:round_feedback).with(8, 'two').ordered
        expect(output).to receive(:round_feedback).with(7, 'three').ordered
        expect(output).to receive(:round_feedback).with(6, 'four').ordered
        expect(output).to receive(:round_feedback).with(5, 'five').ordered
        expect(output).to receive(:round_feedback).with(4, 'six').ordered
        expect(output).to receive(:round_feedback).with(3, 'seven').ordered
        expect(output).to receive(:round_feedback).with(2, 'eight').ordered
        expect(output).to receive(:round_feedback).with(1, 'nine').ordered
        expect(output).to receive(:round_feedback).with(0, 'right').ordered

        game.start
      end
      it 'generates a hint ten times' do
        expect(validator).to receive(:hint).exactly(10).times
        game.start
      end
      it 'stops prompting the player after a correct guess' do
        expect(player).to receive(:guess).exactly(10).times
        game.start
      end
      it 'checks if guess is correct ten times' do
        expect(validator).to receive(:correct?).exactly(10).times
        game.start
      end
    end

    context 'player is never right' do

      before do
        allow(validator).to receive(:hint).and_return('incorrect')
        allow(player).to receive(:guess).and_return('aaaa')
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(validator).to receive(:correct?).and_return(false)
      end
    end
  end
end
