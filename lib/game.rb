class Game
  def initialize(messages)
    @messages = messages
    @total_guesses = 10
  end

  def start
    @messages.greet
    until game_over
      player_turn
    end
    @messages.goodbye
  end

  def player_turn
    @messages.prompt_guess(@total_guesses)
    user_input
    @total_guesses -= 1
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end

  def game_over
    @total_guesses == 0
  end
end
