class CodeGenerator
  def initialize
    @pool = ["A","B","C","D","E","F"]
  end

  def generate
    new_code = ""
    4.times do
      new_code.concat(random_character)
    end
    return new_code
  end

  def random_character
    @pool.sample
  end
end
