class GuessValidator
  def initialize(params)
    @code  = params[:hidden_code]
    @guess = params[:guess]
  end

  def correct?
    capitalize(@code) == capitalize(@guess)
  end

  def hint
    @hint ||= validation
  end

  private

  def used_character
    nil
  end

  def capitalize(string)
    string.upcase
  end

  def format_code(string)
    capitalize(string).split('')
  end

  def validation
    code_array  = format_code(@code)
    guess_array = format_code(@guess)
    response    = String.new

    guess_array.each_with_index do |char, index|

      if char == code_array[index] && char != used_character

        response.concat('o')
        code_array[index]  = used_character
        guess_array[index] = used_character
      end

      if char != used_character && code_index = code_array.index(char)

        response.concat('x')
        code_array[code_index] = used_character
        guess_array[index]     = used_character
      end
    end

    response
  end
end
