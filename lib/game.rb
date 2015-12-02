class Game
  def initialize(messages)
    @messages = messages
    start
  end

  def start
    @messages.greet

    guesses = 10
    until guesses == 0
      @messages.prompt_guess(guesses)
      user_input
      guesses -= 1
    end

    @messages.goodbye
  end

  def user_input
    @messages.prompt_input
    gets.chomp
  end
end
