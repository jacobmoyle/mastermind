class GuessValidator
  def initialize(params)
    @code  = params[:hidden_code]
    @guess = params[:guess]
  end

  def correct?
    @code == @guess
  end

  def hint
    @hint ||= validation
  end

  private

  def validation
    code_array = format_code(@code)
    guess_array = format_code(@guess)
    response = ''

    guess_array.each_with_index do |char, index|
      if char == code_array[index] && char != ' '
        response.concat('o')
        code_array[index] = ' '
        guess_array[index] = ' '
      end

      if char != ' ' && code_index = code_array.index(char)
        response.concat('x')
        code_array[code_index] = ' '
        guess_array[index] = ' '
      end
    end

    response
  end

  def format_code(string)
    string.upcase.split('')
  end
end
