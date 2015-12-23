class GuessValidator
  def initialize(params)
    @code  = format_code(params[:hidden_code])
    @guess = format_code(params[:guess])
  end

  def correct?
    @code == @guess
  end

  def hint
    @hint ||= exact_feedback.concat(character_feedback).join
  end

  private

  def format_code(string)
    string.upcase.split('')
  end

  def exact_feedback
    @used_indices = []
    results = []

    @guess.each_with_index do |char, index|
      if @code[index] == char
        results << 'o'
        @used_indices << index
      end
    end

    results
  end

  def character_feedback
    results = []

    unused_characters(@guess, '+').uniq.each do |character|
      results << 'x' if unused_characters(@code, '-').include?(character)
    end

    results
  end

  def unused_characters(sequence, matched_placeholder)
    new_sequence = sequence.clone

    @used_indices.each do |position|
      new_sequence[position] = matched_placeholder
    end

    new_sequence
  end
end
