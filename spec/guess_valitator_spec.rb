require_relative '../lib/guess_validator'
require_relative '../lib/code_generator'

describe GuessValidator do
  code = CodeGenerator.new.generate
  subject { GuessValidator.new(code) }
2127 Larkin St, San Francisco, CA 94109
end