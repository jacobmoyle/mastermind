class Game
  def initialize(messages)
    @messages = messages
    @total_guesses = 10
    start
  end

  def start
    @messages.greet

    until @total_guesses == 0
      player_turn
      @total_guesses -= 1
    end

    @messages.goodbye
  end

  def player_turn
    @messages.prompt_guess(@total_guesses)
    user_input
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end
end
