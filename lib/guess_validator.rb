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
  end

  def set_code(code)
    @unsolved_code = format_code(code)
  end

  def validate(player_guess)
    formatted_guess = format_code(player_guess)

    if formatted_guess.length != @unsolved_code.length
      return 'Guess length is incorrect, code is 4 characters'
    else
      return guess_feedback(@unsolved_code, formatted_guess)
    end
  end

  private

  def guess_feedback(objective, attempt)
    response = ''
    objective.each_with_index do |char, curr_index|
      if char == attempt[curr_index]
        response.concat('o')
      elsif attempt.include?(char)
        response.concat('x')
      end
    end
    response
  end

  def format_code(guess)
    guess.upcase.split('')
  end
end
