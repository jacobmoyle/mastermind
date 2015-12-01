require_relative 'messages'

class Game
  def initialize
    @messenger = Messages.new
  end

  def start
    @messenger.greeting
    get_user_input
    @messenger.goodbye
  end

  def get_user_input
    gets.chomp
  end
end