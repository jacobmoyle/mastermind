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
    player_code = format_code(player_guess)
    response = ''

    @unsolved_code.each_with_index do |char, curr_index|
      if char == player_code[curr_index]
        response.concat('o')
      elsif player_code.include?(char)
        response.concat('x')
      end
    end

    response = nil if player_code.length != @unsolved_code.length

    response
  end

  private

  def format_code(guess)
    guess.upcase.split('')
  end
end
