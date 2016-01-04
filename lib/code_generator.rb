class CodeGenerator
  def initialize(pool = ["A","B","C","D","E","F"], length = 4)
    @char_pool   = pool
    @code_length = length
  end

  def generate
    new_code = ""
    @code_length.times do
      new_code.concat(random_character)
    end
    new_code
  end

  private

  def random_character
    @char_pool.sample
  end
end
