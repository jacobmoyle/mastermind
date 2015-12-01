class CodeGenerator
  def initialize
    @pool = ["A","B","C","D","E","F"]
    @code_length = 4
  end

  def generate
    new_code = ""
    @code_length.times do
      new_code.concat(random_character)
    end
    return new_code
  end

  def random_character
    @pool.sample
  end
end
