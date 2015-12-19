require_relative '../lib/game'

describe Game do
  let(:player)     { double('input', guess: 'temp') }
  let(:code_maker) { double('code', generate: '') }
  let(:validator)  { double('feedback', hint: 'hint', correct?: nil) }
  let(:output)     { double('view', greeting: 'hi', guess_prompt: 'input something', round_feedback: 'things happened', goodbye: 'fin')}
  let(:game)       { Game.new( input: player, code_maker: code_maker, code_checker: validator, view: output) }


  describe '#start' do

    it 'requests input from the player' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)

      expect(player).to receive(:guess)

      game.start
    end


    it 'provides a hint to the players last guess' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)
      allow(validator).to receive(:hint).and_return('recent hint')

      expect(output).to receive(:round_feedback).with(any_args, 'recent hint')

      game.start
    end

    it 'ends the game if a player is wrong ten times  ' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)
      expect(player).to receive(:guess).exactly(10).times
      expect(output).to receive(:goodbye)

      game.start
    end

    it 'ends the game if a player guesses correctly' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)
      allow(code_maker).to receive(:generate).and_return('cccc')
      allow(player).to receive(:guess).and_return('cccc')
      allow(validator).to receive(:correct?).and_return(true)

      expect(player).to receive(:guess).once
      expect(output).to receive(:goodbye)

      game.start
    end
  end

  # describe '#new_hidden_code' do
  #   it 'provides a new code' do
  #     rand_string = (0...8).map { (65 + rand(26)).chr }.join
  #     allow(code_maker).to receive(:generate).and_return(rand_string)

  #     expect(game.new_hidden_code).to eq(rand_string)
  #   end
  # end

  # describe '#hint_for' do
  #   let(:guess) { double('guess object') }

  #   it 'provides feedback on the players guess' do
  #     allow(guess).to receive(:hint).and_return('some feedback')

  #     expect(game.hint_for(guess)).to eq('some feedback')
  #   end
  # end

  # describe '#game_over?' do

  #   let(:guess) { double('response') }

  #   it 'returns false is the player has remaining turns and guessed incorrectly' do
  #     turns = 5
  #     allow(guess).to receive(:correct?).and_return(false)

  #     expect(game.game_over?(guess, turns)).to eq(false)
  #   end

  #   it 'returns true if the player is out of turns' do
  #     turns = 0
  #     allow(guess).to receive(:correct?).and_return(false)

  #     expect(game.game_over?(guess, turns)).to eq(true)
  #   end

  #   it 'returns true if the player guesses correctly' do
  #     turns = 5
  #     allow(guess).to receive(:correct?).and_return(true)

  #     expect(game.game_over?(guess, turns)).to eq(true)
  #   end
  # end
end

