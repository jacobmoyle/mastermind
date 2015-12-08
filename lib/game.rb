class Game
  def initialize(terminal_messages, code_validator, guesses = 10)
    @messages          = terminal_messages
    @guess_checker     = code_validator
    @remaining_guesses = guesses
    @feedback          = nil
    @guess             = nil
  end

  def start
    @messages.greet

    until game_over
      get_player_guess
      get_guess_feedback

      p "target: #{@guess_checker.unsolved_code}"

      provide_feedback

      complete_turn
    end

    @messages.goodbye
  end

  def provide_feedback
    @messages.guess_feedback(@feedback)
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end

  def get_player_guess
    @messages.prompt_guess(@remaining_guesses)
    @guess = user_input
  end

  def get_guess_feedback
    @feedback = @guess_checker.validate(@guess)
  end

  def complete_turn
    @remaining_guesses -= 1
  end

  def game_over
    @feedback == 'oooo' || @remaining_guesses == 0
  end
end
