require_relative 'lib/game'
require_relative 'lib/messages'
require_relative 'lib/code_generator'
require_relative 'lib/guess_validator'

# Looks smelly, CodeGenerator is only able to be used once.
Game.new(
  Messages.new,
  # Should validator be aware of the generator and be able to create a new code?
  GuessValidator.new(
    CodeGenerator.new.generate)
  ).start
