class GuessValidator

  def initialize
    @place_holder = ' '
    @exact_match_char = 'o'
    @contains_match_char = 'x'
    @response = ''
    @error = 'Code length is incorrect, code is 4 characters'
  end

  def validate(unsolved_code, player_code)
    set_instance_variables(unsolved_code, player_code)
    @response = ''

    return @error if @formatted_guess.length != @unsolved_code.length

    create_feedback
    @response
  end

  private

  def create_feedback
    @formatted_guess.each_with_index do |guess, guess_index|
      exact_feedback(guess_index) if perfect_match?(guess, guess_index)

      target_index = @unsolved_code.index(guess)

      relative_feedback(guess_index, target_index) if relative_match?(guess, target_index)
    end
  end

  def relative_match?(guess_char, target)
    unused_character?(guess_char) && target != nil
  end

  def relative_feedback(guess_index, target_index)
    add_character_feedback(@contains_match_char)

    mark_as_used(@unsolved_code, target_index)
    mark_as_used(@formatted_guess, guess_index)
  end

  def perfect_match?(guess_char, guess_index)
    guess_char == @unsolved_code[guess_index] && unused_character?(guess_char)
  end

  def exact_feedback(index)
    add_character_feedback(@exact_match_char)

    mark_as_used(@unsolved_code, index)
    mark_as_used(@formatted_guess, index)
  end

  def

  def reset_response
    @response = ''
  end

  def add_character_feedback(feedback)
    @response.concat(feedback)
  end

  def unused_character?(char)
    char != @place_holder
  end

  def set_instance_variables(unsolved_code, player_code)
    @unsolved_code    = format_code(unsolved_code)
    @formatted_guess  = format_code(player_code)
  end

  def mark_as_used(array, index)
    array[index] = @place_holder
  end

  def format_code(guess)
    guess.upcase.split('')
  end
end
