require_relative '../lib/guess_validator'
require_relative '../lib/code_generator'

describe GuessValidator do
  code = CodeGenerator.new.generate
  subject { GuessValidator.new(code) }

end