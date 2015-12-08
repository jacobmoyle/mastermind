class Game
  def initialize(terminal_messages, code_validator, guesses = 10)
    @messages          = terminal_messages
    @guess_checker     = code_validator
    @remaining_guesses = guesses
    @guess_feedback    = nil
    @guess             = nil
  end

  def start
    @messages.greet

    until game_over
      new_player_guess
      update_guess_feedback

      p "target: #{@guess_checker.unsolved_code}"

      provide_feedback
      complete_turn
    end

    @messages.goodbye
  end

  def provide_feedback
    @messages.feedback(@guess_feedback)
  end

  def new_player_guess
    @messages.prompt_guess(@remaining_guesses)
    @guess = user_input
  end

  def update_guess_feedback
    @guess_feedback = @guess_checker.validate(@guess)
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end

  def complete_turn
    @remaining_guesses -= 1
  end

  def game_over
    @guess_feedback == 'oooo' || @remaining_guesses == 0
  end
end
