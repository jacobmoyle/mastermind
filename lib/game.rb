class Game
  def initialize(terminal_messages, code_validator, guesses = 10)
    @messages          = terminal_messages
    @guess_checker     = code_validator
    @remaining_guesses = guesses
  end

  def start
    @messages.greet

    until game_over
      player_turn
    end

    @messages.goodbye
  end

  def player_turn
    @messages.prompt_guess(@remaining_guesses)
    p "target: #{@guess_checker.unsolved_code}"
    p @guess_checker.validate(user_input)
    @remaining_guesses -= 1
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end

  def game_over
    @remaining_guesses == 0
  end
end
