class Game
  def initialize(params)
    @validator  = params.fetch(:code_checker)
    @code_maker = params.fetch(:code_maker)
    @input      = params.fetch(:input)
    @output     = params.fetch(:view)
    @rules      = params.fetch(:game_rules)
  end

  def start
    code = new_hidden_code
    output_start

    loop do
      incriment_turn
      guess = new_guess(code, valid_guess)
      output_round_feedback(remaining_turns, guess.hint)
      break if conditions_met(guess.correct?)
    end

    output_end
  end

  private

  def conditions_met(guess_outcome)
    @rules.game_over?(guess_outcome)
  end

  def hint_for(guess)
    guess.hint
  end

  def remaining_turns
    @rules.turns
  end

  def output_start
    @output.greeting
  end

  def incriment_turn
    @rules.subtract_turn
  end

  def output_end
    @output.goodbye
  end

  def new_guess(code, new_guess)
    @validator.new(hidden_code: code, guess: new_guess)
  end

  def output_round_feedback(turns, hint)
    @output.round_feedback(turns, hint)
  end

  def new_hidden_code
    @code_maker.generate
  end

  def valid_guess
    @output.guess_prompt
    new_guess = @input.guess

    until @rules.valid_guess?(new_guess)
      @output.guess_invalid
      @output.guess_prompt
      new_guess = @input.guess
    end

    new_guess
  end
end
