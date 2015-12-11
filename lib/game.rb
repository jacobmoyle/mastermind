class Game
  def initialize(params)
    @messages          = params.fetch(:terminal_messages)
    @guess_checker     = params.fetch(:code_validator)
    @code_generator    = params.fetch(:code_generator)
    @remaining_guesses = params.fetch(:attempts, 10)
    @last_guess        = nil
    @player            = params.fetch(:guess_generator)
  end

  def start
    @messages.greet
    @hidden_code = @code_generator.generate

    until game_over
      get_guess
      get_validator_response
      output_validator_response

      p "target: #{@hidden_code}"
      complete_turn
    end

    @messages.goodbye
  end

  private

  def output_validator_response
    @messages.feedback(@validator_response)
  end

  def get_validator_response
    @validator_response = @guess_checker.validate(@hidden_code, @last_guess)
  end

  def get_guess
    @messages.prompt_guess(@remaining_guesses)
    update_last_guess
  end

  def update_last_guess
    @last_guess = @player.new_guess
  end

  def complete_turn
    @remaining_guesses -= 1
  end

  def game_over
    @validator_response == 'oooo' || @remaining_guesses == 0
  end
end
