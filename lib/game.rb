class Game
  def initialize(params)
    @messages          = params.fetch(:terminal_messages)
    @guess_checker     = params.fetch(:code_validator)
    @code_generator    = params.fetch(:code_generator)
    @remaining_guesses = params.fetch(:attempts, 10)
  end

  def start
    @messages.greet
    @hidden_code = @code_generator.generate

    until game_over
      give_player(
        validators_response_for(
          players_new_guess))

      p "target: #{@hidden_code}"
      complete_turn
    end

    @messages.goodbye
  end

  private

  def give_player(message)
    @messages.feedback(message)
  end

  def validators_response_for(player_guess)
    @validator_response = @guess_checker.validate(@hidden_code, player_guess)
  end

  def players_new_guess
    @messages.prompt_guess(@remaining_guesses)
    user_input
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end

  def complete_turn
    @remaining_guesses -= 1
  end

  def game_over
    @validator_response == 'oooo' || @remaining_guesses == 0
  end
end
