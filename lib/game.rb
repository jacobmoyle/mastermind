class Game
  def initialize(params)
    @validator  = params.fetch(:code_checker)
    @code_maker = params.fetch(:code_maker)
    @player     = params.fetch(:input)
  end

  def start
    turns = 10
    hidden_code = new_hidden_code

    loop do
      guess = @validator.new(hidden_code, player_guess)
      hint_for(guess)
      game_over?(guess, turns)
      turns -= 1
    end
  end

  def new_hidden_code
    @code_maker.generate
  end

  def player_guess
    input = ''
    until input.length == 4
      input = @player.guess
    end
    input
  end

  def hint_for(guess)
    guess.hint
  end

  def game_over?(guess, turns)
    guess.correct? || turns == 0
  end
end
