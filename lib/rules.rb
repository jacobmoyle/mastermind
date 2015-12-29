class Rules
  attr_reader :turns

  def initialize
    @turns = 9
  end

  def valid_guess?(string)
    guess = format(string)

    correct_length?(guess) && valid_characters?(guess)
  end

  def turn_over
    @turns -= 1
    if @turns == -1
      raise "No turns remain"
    end
  end

  private

  def valid_characters?(guess)
    valid_char = ['a','b','c','d','e','f']
    guess.drop_while { |char|
      valid_char.include?(char)
    }.empty?
  end

  def correct_length?(guess)
    guess.length == 4
  end

  def format(string)
    string.split('')
  end
end
