require_relative '../lib/game'
require_relative '../lib/guess_validator'
require_relative '../lib/code_generator'

describe Game do
  let(:player)     { double('input') }
  let(:code_maker) { double('code') }
  let(:validator)  { GuessValidator.new }
  let(:game)       { Game.new( input: player, code_checker: validator,
   code_maker: code_maker,) }

  describe '#player_guess' do
    it 'asks a player for input until the input is valid' do
      allow(code_maker).to receive(:generate).and_return('abcd')
      allow(player).to receive(:guess).and_return( '', 'aaabbb', '1x23')

      expect(game.player_guess.length).to eq(code_maker.generate.length)
    end
  end

  describe '#set_hidden_code' do
    it 'updates the hidden code' do
      allow(code_maker).to receive(:generate).and_return('abcd')

      previous_code = game.hidden_code
      game.new_hidden_code

      expect(game.hidden_code).to_not eq(previous_code)
    end
  end

  xit 'outputs correct feedback for the players input' do
    # allow(player).to receive(:guess).and_return(code_maker.generate)

    # expected_response = validator.validate(
      # code_maker.generate, player.guess)

    # expect(game.feedback).to eq(expected_response)
  end

  xit 'ends the game if the player is out of guesses' do
  end

  xit 'ends the game if the player guesses correctly' do
  end
end


