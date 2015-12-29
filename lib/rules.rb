class Rules
  attr_reader :turns
  def initialize
    @turns = 9
  end

  def valid_guess?(string)
    guess = format(string)
    valid_char = ['a','b','c','d','e','f']

    return true if guess.length == 4 &&
    guess.drop_while { |char|
      valid_char.include?(char)
      }.empty?
    false
  end

  def turn_over
    @turns -= 1
    if @turns == -1
      raise "No turns remain"
    end
  end

  private

  def format(string)
    string.split('')
  end
end