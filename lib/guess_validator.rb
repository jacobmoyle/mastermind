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
  attr_accessor :unsolved_code
  def initialize(unsolved_code)
    @unsolved_code = unsolved_code
  end


end