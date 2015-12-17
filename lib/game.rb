class Game
  def initialize(params)
    @validator  = params.fetch(:code_checker)
    @code_maker = params.fetch(:code_maker)
    @player     = params.fetch(:input)
    @output     = params.fetch(:view)
  end

  def start
    turns = 10
    code = new_hidden_code

    @output.greeting

    loop do
      @output.guess_prompt
      guess = @validator.new(hidden_code: code, guess: player_guess)
      @output.round_feedback(turns, hint_for(guess))

      break if game_over?(guess, turns)

      turns -= 1
    end

    @output.goodbye
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
