require_relative '../lib/game'
require_relative '../lib/view'
require_relative '../lib/code_generator'
require_relative '../lib/guess_feedback'
require_relative '../lib/player'
require_relative '../lib/rules'

Game.new(
  :code_checker => GuessFeedback,
  :code_maker   => CodeGenerator.new,
  :input        => Player.new,
  :view         => View.new,
  :game_rules   => Rules.new
).start
