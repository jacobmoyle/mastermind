class Rules
  attr_reader :turns

  def initialize
    @turns = 9
  end

  def valid_guess?(string)
    input = format(string)

    correct_length?(input) && valid_characters?(input)
  end

  def game_over?(guess)
    guess.correct? || turns == 0
  end

  def turn_over
    @turns -= 1
    if @turns == -1
      raise "No turns remain"
    end
  end

  private

  def valid_characters?(array)
    valid_char = ['a','b','c','d','e','f']
    array.drop_while { |char|
      valid_char.include?(char)
    }.empty?
  end

  def correct_length?(input)
    input.length == 4
  end

  def format(string)
    string.split('')
  end
end
