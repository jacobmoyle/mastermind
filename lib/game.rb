require_relative 'messages'

class Game
  def initialize
    @messenger = Messages.new
  end

  def start
    @messenger.greeting
    @messenger.goodbye
  end
end