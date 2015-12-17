require_relative 'lib/game'
require_relative 'lib/messages'
require_relative 'lib/code_generator'
require_relative 'lib/guess_validator'
require_relative 'lib/player'

Game.new(
  :terminal_messages => Messages.new,
  :code_checker      => GuessValidator,
  :code_maker        => CodeGenerator.new,
  :input             => Player.new
  ).start
