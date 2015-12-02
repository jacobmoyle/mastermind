class Game
  def initialize(messages)
    @messages = messanges
    start
  end

  def start
    @messages.greet
    get_user_input
    @messages.goodbye
  end

  def get_user_input
    @messages.prompt_input
    gets.chomp
  end
end
