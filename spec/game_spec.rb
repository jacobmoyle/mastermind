require 'spec_helper'

describe Game do
  let(:output)     { View.new }
  let(:rules)      { double('rules') }
  let(:player)     { double('input') }
  let(:code_maker) { double('code') }
  let(:validator)  { double('feedback') }
  let(:game)       { Game.new(
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
      allow(rules).to receive(:turns).with(no_args).and_return(9,8,7,6,5,4,3,2,1,0)
      allow(rules).to receive(:valid_guess?).with(an_instance_of(String)).and_return(true)
    end

    context 'when input is incorrect' do

      before do
        allow(validator).to receive(:feedback).and_return('feedback')
        allow(player).to receive(:guess).and_return('wrong','valid')
        allow(rules).to receive(:valid_guess?).with('wrong').and_return(false)
        allow(rules).to receive(:valid_guess?).with('valid').and_return(true)
        allow(code_maker).to receive(:generate).and_return('code')
        allow(rules).to receive(:game_over?).and_return(false,true)
        allow(rules).to receive(:winning_feedback?).with(any_args).and_return(true)
      end

      it 'an error will be sent to the user' do
        expect(output).to receive(:guess_invalid).once
        game.start
      end
      it 'a turn will be used only after a valid guess has been submitted' do
        expect(rules).to receive(:subtract_turn).ordered
        expect(player).to receive(:guess).twice.ordered
        expect(rules).to receive(:subtract_turn).ordered
        expect(player).to receive(:guess).ordered
        game.start
      end
    end

    context 'first guess is correct' do

      before do
        allow(rules).to receive(:game_over?).and_return(true)
        allow(validator).to receive(:feedback).and_return('correct')
        allow(player).to receive(:guess).and_return('abcd')
        allow(code_maker).to receive(:generate).and_return('abcd')
      end

      it "outputs '9' turns remaining and 'correct' for feedback" do
        expect(output).to receive(:round_feedback).with(9, 'correct').once
        game.start
      end
      it 'checks if guess is correct once' do
        expect(rules).to receive(:game_over?).with(any_args).once
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
        allow(rules).to receive(:game_over?).and_return(false)
        allow(rules).to receive(:game_over?).with('right').and_return(true)
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(player).to receive(:guess).and_return('aaaa')
        allow(validator).to receive(:feedback).and_return(
          'one','two','three','four','five','six','seven','eight','nine','right')
      end

      it 'outputs the current turn and corresponding guess feedback' do
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
        expect(validator).to receive(:feedback).exactly(10).times
        game.start
      end
      it 'stops prompting the player after a correct guess' do
        expect(player).to receive(:guess).exactly(10).times
        game.start
      end
      it 'checks if guess is correct ten times' do
        expect(rules).to receive(:game_over?).with(any_args).exactly(10).times
        game.start
      end
      it 'reduces turns remaining ten times' do
        expect(rules).to receive(:subtract_turn).exactly(10).times
        game.start
      end
    end

    context 'player is never right' do

      before do
        allow(rules).to receive(:game_over?).and_return(
          false,false,false,false,false,false,false,false,false,true)
        allow(validator).to receive(:feedback).and_return('incorrect')
        allow(player).to receive(:guess).and_return('aaaa')
        allow(code_maker).to receive(:generate).and_return('ffff')
        allow(rules).to receive(:winning_feedback?).with(any_args).and_return(false)
      end

      it 'outputs the turn and corresponding guess feedback' do
        expect(output).to receive(:round_feedback).with(
          an_instance_of(Fixnum), 'incorrect').ordered.exactly(10).times
        game.start
      end
      it 'stops prompting the player after all guesses are used' do
        expect(player).to receive(:guess).exactly(10).times
        game.start
      end
    end
  end
end
