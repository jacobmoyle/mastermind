class Rules
  attr_reader :turns

  def initialize(total_turns = 10, code_length = 4)
    @length = code_length
    @turns  = total_turns
  end

  def valid_guess?(input)
    correct_length?(input) && valid_characters?(input)
  end

  def game_over?(guess_outcome)
    guess_outcome || @turns == 0
  end

  def subtract_turn
    @turns -= 1
    if @turns == -1
      raise "No turns remain"
    end
  end

  private

  def valid_characters?(string)
    valid_char = ['a','b','c','d','e','f']
    format(string).drop_while { |char|
      valid_char.include?(char)
    }.empty?
  end

  def correct_length?(input)
    input.length == @length
  end

  def format(string)
    string.split('')
  end
end
