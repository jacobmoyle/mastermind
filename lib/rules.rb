class Rules
  attr_reader :turns

  def initialize(total_turns = 10)
    @turns = total_turns
  end

  def valid_guess?(input)
    formatted_input = format(input)
    correct_length?(formatted_input) && all_valid?(formatted_input)
  end

  def game_over?(guess_feedback)
    winning_feedback?(guess_feedback) || out_of_turns?
  end

  def subtract_turn
    raise_turn_error if out_of_turns?
    @turns -= 1
  end

  private

  def winning_feedback?(feedback)
    feedback == 'oooo'
  end

  def out_of_turns?
    @turns == 0
  end

  def raise_turn_error
    raise "No turns remain"
  end

  def all_valid?(array)
    array.any?{ |char| invalid?(char) } ? false : true
  end

  def invalid?(char)
    ['a','b','c','d','e','f'].include?(char) ? false : true
  end

  def correct_length?(code)
    code.length == 4
  end

  def format(string)
    string.downcase.split('')
  end
end
