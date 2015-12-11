class GuessValidator

  def initialize
    @holder = ' '
  end

  def validate(unsolved_code, player_code)
    set_instance_variables(unsolved_code, player_code)

    if @formatted_guess.length != @unsolved_code.length
      'Code length is incorrect, code is 4 characters'
    else
      return_hint
    end
  end

  private

  def return_hint
    response = ''

    @formatted_guess.each_with_index do |char, curr_index|
      if char == @unsolved_code[curr_index] && char != @holder
        response.concat('o')
        overwrite(@unsolved_code, curr_index)
        overwrite(@formatted_guess, curr_index)
      end
    end

    @formatted_guess.each_with_index do |char, curr_index|
      if char != @holder
        location = @unsolved_code.index(char)
        if location != nil
          response.concat('x')
          overwrite(@unsolved_code, location)
          overwrite(@formatted_guess, curr_index)
        end
      end
    end

    response
  end

  def set_instance_variables(unsolved_code, player_code)
    @unsolved_code    = format_code(unsolved_code)
    @formatted_guess  = format_code(player_code)
  end

  def overwrite(array, index)
    array[index] = @holder
  end

  def format_code(guess)
    guess.upcase.split('')
  end
end
