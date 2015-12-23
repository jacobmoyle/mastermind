class Game
  def initialize(params)
    @validator  = params.fetch(:code_checker)
    @code_maker = params.fetch(:code_maker)
    @player     = params.fetch(:input)
    @output     = params.fetch(:view)
  end

  def start
    turns = 9
    code = new_hidden_code

    @output.greeting

    loop do
      # move this into prompt loop
      @output.guess_prompt
      guess = @validator.new(hidden_code: code, guess: player_guess)
      # hint_for seems to bury guess hint too much, remove
      @output.round_feedback(turns, hint_for(guess))

      break if game_over?(guess, turns)

      turns -= 1
    end

    @output.goodbye
  end

  private

  def new_hidden_code
    @code_maker.generate
  end

  def player_guess
    input = ''
    until @rules.valid_guess?(input)
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
