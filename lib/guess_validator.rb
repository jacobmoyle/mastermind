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

  def initialize(unsolved_code)
    set_code(unsolved_code)
    @response_template = Struct.new(:feedback)
  end

  def validate(guess)
    player_code = convert_to_arr(guess)

    response = @response_template.new('')

    @unsolved_code.each_with_index do |char, curr_index|
      if char == player_code[curr_index]
        response.feedback.concat('o')
      elsif player_code.include?(char)
        response.feedback.concat('x')
      end
    end

    response
  end

  def set_code(new_code)
    @unsolved_code = convert_to_arr(new_code)
  end

  def convert_to_arr(string)
    clean(string).split('')
  end

  def clean(new_code)
    new_code.upcase
  end

end
