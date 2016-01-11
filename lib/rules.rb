class Rules
  attr_reader :turns

  def initialize(total_turns = 10)
    @turns = total_turns
  end

  def valid_guess?(input)
    correct_length?(input) && valid_characters?(input)
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

  def valid_characters?(string)
    formatted(string).drop_while { |char|
      check_character?(char)
    }.empty?
  end

  def check_character?(char)
    ['a','b','c','d','e','f'].include?(char)
  end

  def correct_length?(input)
    input.length == 4
  end

  def formatted(string)
    string.downcase.split('')
  end
end
