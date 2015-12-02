class Game
  def initialize(messages)
    @messages = messages
    start
  end

  def start
    @messages.greet

    guesses = 10
    until guesses == 0
      @messages.player_turn(guesses)
      guesses -= 1
    end

    @messages.goodbye
  end
end
