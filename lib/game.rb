require_relative 'messages'

class Game
  def initialize
    @messages = Messages.new
    run
  end

  def run
    @messages.greet
    get_user_input
    @messages.goodbye
  end

  def get_user_input
    @messages.prompt_input
    gets.chomp
  end
end