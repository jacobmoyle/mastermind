class CodeGenerator
  def initialize
    @character_pool = ["A","B","C","D","E","F"]
  end

  def generate
    new_code = ""
    code_length.times do
      new_code.concat(random_character)
    end
    new_code
  end

  private

  def code_length
    4
  end

  def random_character
    @character_pool.sample
  end
end
