class Game
  def initialize(params)
    @validator  = params.fetch(:code_checker)
    @code_maker = params.fetch(:code_maker)
    @player     = params.fetch(:input)
    @output     = params.fetch(:view)
    @rules      = params.fetch(:game_rules)
  end

  def start
    turns = 9
    code = new_hidden_code

    output_start
    loop do
      guess = new_guess(code, player_guess)
      output_round_feedback(turns, hint_for(guess))

      break if game_over?(guess, turns)

      turns -= 1
    end
    output_end
  end

  private

  def output_start
    @output.greeting
  end

  def output_end
    @output.goodbye
  end

  def new_guess(code, guess)
    @validator.new(hidden_code: code, guess: guess)
  end

  def output_round_feedback(turns, hint)
    @output.round_feedback(turns, hint)
  end

  def new_hidden_code
    @code_maker.generate
  end

  def player_guess
    input = ''
    until @rules.valid_guess?(input)
      @output.guess_prompt
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
