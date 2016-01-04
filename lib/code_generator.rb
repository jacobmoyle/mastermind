class CodeGenerator
  def generate
    new_code = ""
    4.times do
      new_code.concat(random_character)
    end
    new_code
  end

  private

  def random_character
    ["A","B","C","D","E","F"].sample
  end
end
