=begin
Needs to have the code
Needs to have the user guess

Compares the code and the users guess
Provides feedback
- If users guess is correct
- If users guess is completely wrong
- If users guess contains characters that are correct
- If users guess contains characters that are correct and in the correct position
=end

class GuessValidator
  attr_reader :unsolved_code

  def initialize(new_code)
    set_code(new_code)
    @response_template = Struct.new(:feedback, :error)
  end

  def set_code(code)
    @unsolved_code = format_code(code)
  end

  def validate(player_guess)
    player_code = format_code(player_guess)
    prepare_new_response
    error_check(player_code)

    @unsolved_code.each_with_index do |char, curr_index|
      if char == player_code[curr_index]
        @response.feedback.concat('o')
      elsif player_code.include?(char)
        @response.feedback.concat('x')
      end
    end

    @response
  end

  private

  def prepare_new_response
    @response = @response_template.new('', nil)
  end

  # Should validator error check? Is this even necissary this deep? Should the view or game do this?
  def error_check(code)
    if code.length > @unsolved_code.length
      @response.error = 'Input is too long.'
    elsif code.length < @unsolved_code.length
      @response.error = 'Input is too short.'
    end
  end

  def format_code(guess)
    guess.upcase.split('')
  end
end
