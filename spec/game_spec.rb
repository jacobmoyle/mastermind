require_relative '../lib/game'

describe Game do
  let(:messages) { double('messages', greet: , goodbye: , feedback: , prompt_guess: ) }
  let(:validator) { double('validator', validate: , winning_response,  ) }
  it 'does something' do
    game_params = {
      terminal_messages: nil,
      code_validator: nil,
      code_generator: nil,
      guess_generator: nil,
    }
    game = described_class.new(game_params)
  end

  it 'accepts a players input' do
  end

  it 'provides feedback to the players input' do
  end

  it 'ends the game if the player is out of guesses' do
  end

  it 'ends the game if the player guesses correctly' do
  end
end


