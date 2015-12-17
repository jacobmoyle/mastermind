class Game
  attr_reader :hidden_code
  def initialize(params)
#     @messages          = params.fetch(:terminal_messages)
    # @validator  = params.fetch(:code_checker)
    @code_maker = params.fetch(:code_maker)
#     @remaining_guesses = params.fetch(:attempts, 10)
    @player = params.fetch(:input)
#     @last_guess        = nil
    @hidden_code    = nil
  end

  def start
    new_hidden_code
    player_guess
#     @messages.greet
#     @hidden_code = @code_maker.generate

#     until game_over
      # guess = player_guess
#       update_validator_response
#       output_validator_response

#       p "target: #{@hidden_code}"

#       complete_turn
#     end

#     @messages.goodbye
  end

  def new_hidden_code
    @hidden_code = @code_maker.generate
  end

  def player_guess
    input = ''
    until input.length == 4
      input = @player.guess
    end
    input
  end

  # def feedback
  #   @validator.validate(player_guess)
  # end

#   private

#   def output_validator_response
#     @messages.feedback(@validator_response)
#   end

#   def update_validator_response
#     @validator_response = @guess_checker.validate(@hidden_code, @last_guess)
#   end

#   def get_guess
#     @messages.prompt_guess(@remaining_guesses)
#     update_last_guess
#   end

#   def update_last_guess
#     @last_guess = @player.new_guess
#   end

#   def complete_turn
#     @remaining_guesses -= 1
#   end

#   def game_over
#     @validator_response == @guess_checker.winning_response || @remaining_guesses == 0
#   end
end
