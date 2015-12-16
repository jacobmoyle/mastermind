require_relative '../lib/game'

describe Game do
  let(:player) { double('input') }
  let(:game) { Game.new(input: player) }

  describe '#player_guess' do
    it 'asks a player for input until the input is valid' do
      allow(player).to receive(:guess).and_return('b','','aaaaa','abcd')

      expect(game.player_guess.length).to be == 4
    end
  end

  xit 'provides feedback to the players input' do
  end

  xit 'ends the game if the player is out of guesses' do
  end

  xit 'ends the game if the player guesses correctly' do
  end
end


