class Rules
  def valid_guess?(string)
    guess = format(string)
    valid_char = ['a','b','c','d','e','f']

    return true if guess.length == 4 &&
    guess.drop_while { |char|
      valid_char.include?(char)
      }.empty?
    false
  end

  private

  def format(string)
    string.split('')
  end
end