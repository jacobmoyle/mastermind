require_relative 'lib/game'
require_relative 'lib/messages'
require_relative 'lib/code_generator'
require_relative 'lib/guess_validator'
require_relative 'lib/player'

Game.new(
  :terminal_messages => Messages.new,
  :code_validator    => GuessValidator.new,
  :code_generator    => CodeGenerator.new,
  :guess_generator   => Player.new
  ).start
