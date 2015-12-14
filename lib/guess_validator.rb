class GuessValidator

  def initialize
    @place_holder = ' '
    @exact_match_char = 'o'
    @contains_match_char = 'x'
    @response = ''
  end

  def validate(unsolved_code, player_code)
    set_instance_variables(unsolved_code, player_code)
    @response = ''

    if @formatted_guess.length != @unsolved_code.length
      'Code length is incorrect, code is 4 characters'
    else
      provide_feedback
    end
  end

  private

  def provide_feedback
    @formatted_guess.each_with_index do |guess, guess_index|

      exact_feedback_for(guess_index) if perfect_match?(guess, guess_index)

      if unused_character?(guess) && target_index = @unsolved_code.index(guess)
        concat_feedback(@contains_match_char)

        mark_as_used(@unsolved_code, target_index)
        mark_as_used(@formatted_guess, guess_index)
      end
    end

    @response
  end


  def perfect_match?(guess_char, guess_index)
    guess_char == @unsolved_code[guess_index] && unused_character?(guess_char)
  end

  def exact_feedback_for(index)
    concat_feedback(@exact_match_char)

    mark_as_used(@unsolved_code, index)
    mark_as_used(@formatted_guess, index)
  end

  def

  def reset_response
    @response = ''
  end

  def concat_feedback(feedback)
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
