class GuessValidator
  def validate(unsolved_code, player_code)
    set_defaults(unsolved_code, player_code)
    return @error if @formatted_guess.length != @unsolved_code.length
    create_feedback
    @response
  end

  private

  def set_defaults(unsolved_code, player_code)
    @unsolved_code        = format_code(unsolved_code)
    @formatted_guess      = format_code(player_code)
    @place_holder         = ' '
    @exact_match_char     = 'o'
    @contains_match_char  = 'x'
    @error                = 'Code length is incorrect, code is 4 characters'
    @response             = ''
  end

  def create_feedback
    @formatted_guess.each_with_index do |character, char_index|
      if perfect_match?(character, char_index)
        provide_exact_feedback(char_index)
      end

      target_index = @unsolved_code.index(character)
      if relative_match?(character, target_index)
        provide_relative_feedback(char_index, target_index)
      end
    end
  end

  def relative_match?(guess_char, target)
    unused_character?(guess_char) && target != nil
  end

  def provide_relative_feedback(guess_index, target_index)
    concat_to_response(@contains_match_char)

    mark_as_used(@unsolved_code, target_index)
    mark_as_used(@formatted_guess, guess_index)
  end

  def perfect_match?(guess_char, guess_index)
    guess_char == @unsolved_code[guess_index] && unused_character?(guess_char)
  end

  def provide_exact_feedback(index)
    concat_to_response(@exact_match_char)

    mark_as_used(@unsolved_code, index)
    mark_as_used(@formatted_guess, index)
  end

  def concat_to_response(feedback)
    @response.concat(feedback)
  end

  def unused_character?(char)
    char != @place_holder
  end

  def mark_as_used(array, index)
    array[index] = @place_holder
  end

  def format_code(guess)
    guess.upcase.split('')
  end
end
