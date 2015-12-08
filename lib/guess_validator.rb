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
  end

  def validate(guess)
    player_code = convert_to_arr(guess)
    answer = ''

    @unsolved_code.each_with_index do |char, curr_index|
      answer.concat('o') if char == player_code[curr_index]
    end

    answer
  end

  def set_code(new_code)
    @unsolved_code = convert_to_arr(new_code)
  end

  def convert_to_arr(string)
    string.split('')
  end

end
