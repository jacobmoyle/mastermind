class GuessValidator

  def validate(unsolved_code, player_code)
    set_code(unsolved_code, player_code)

    if @formatted_guess.length != @unsolved_code.length
      'Guess length is incorrect, code is 4 characters'
    else
      return_hint(@unsolved_code, @formatted_guess)
    end

  end

  private

  def set_code(unsolved_code, player_code)
    @unsolved_code    = format_code(unsolved_code)
    @formatted_guess  = format_code(player_code)
  end

  def return_hint(objective, attempt)
    response = ''

    objective.each_with_index do |char, curr_index|
      if char == attempt[curr_index]
        response.concat('o')
      elsif attempt.include?(char)
        response.concat('x')
      end
    end

    response
  end

  def format_code(guess)
    guess.upcase.split('')
  end
end
