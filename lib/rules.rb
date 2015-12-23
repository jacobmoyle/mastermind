class Rules
  def valid_guess?(guess)
    return true if guess.length == 4
    false
  end
end