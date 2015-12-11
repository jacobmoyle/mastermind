class Game
  def initialize(params)
    @messages          = params.fetch(:terminal_messages)
    @guess_checker     = params.fetch(:code_validator)
    @code_generator    = params.fetch(:code_generator)
    @remaining_guesses = params.fetch(:attempts, 10)
  end

  def start
    # Create a 'clean slate' method? Boots up and sets a new hidden code?
    @messages.greet
    @hidden_code = @code_generator.generate

    until game_over
      give_player(
        validators_response_for(
          players_new_guess))

      p "target: #{@hidden_code}"
      # How will I handle the situation in which a player solves the code on the last guess?
      complete_turn
    end

    # How will I handle the situation in which a player never guesses correctly?
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
    # Should game know what the final feedback should be? Should it be hardcoded?
    @validator_response == 'oooo' || @remaining_guesses == 0
  end
end
