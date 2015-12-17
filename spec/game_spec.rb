require_relative '../lib/game'

describe Game do
  let(:player)     { double('input') }
  let(:code_maker) { double('code') }
  let(:validator)  { double('feedback') }
  let(:game)       { Game.new( input: player, code_maker: code_maker, code_checker: validator) }

  describe '#player_guess' do
    it 'asks a player for input until the input is valid' do
      allow(code_maker).to receive(:generate).and_return('abcd')
      allow(player).to receive(:guess).and_return( '', 'aaabbb', '1x23')

      expect(game.player_guess.length).to eq(code_maker.generate.length)
    end
  end

  describe '#new_hidden_code' do
    it 'provides a new code' do
      rand_string = (0...8).map { (65 + rand(26)).chr }.join
      allow(code_maker).to receive(:generate).and_return(rand_string)

      expect(game.new_hidden_code).to eq(rand_string)
    end
  end

  describe '#hint_for' do
    let(:guess) { double('guess object') }

    it 'provides feedback on the players guess' do
      allow(guess).to receive(:hint).and_return('some feedback')

      expect(game.hint_for(guess)).to eq('some feedback')
    end
  end

  describe '#game_over?' do
    let(:guess) { double('response') }
    it 'returns false is the player has remaining turns and guessed incorrectly' do
      turns = 5
      allow(guess).to receive(:correct?).and_return(false)
      expect(game.game_over?(guess, turns)).to eq(false)
    end
    it 'returns true if the player is out of turns' do
      turns = 0
      allow(guess).to receive(:correct?).and_return(false)
      expect(game.game_over?(guess, turns)).to eq(true)
    end
    it 'returns true if the player guesses correctly' do
      turns = 5
      allow(guess).to receive(:correct?).and_return(true)
      expect(game.game_over?(guess, turns)).to eq(true)
    end
  end

end


