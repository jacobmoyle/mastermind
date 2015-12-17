class View
  def greet
    puts '                 Welcome MasterMind                 '
    puts '                    INSTRUCTIONS                    '
    puts 'The CodeMaker will generate a random pattern        '
    puts 'with 4 of the following letters: A, B, C, D, E, F.  '
    puts 'Your job is to break the code (correct letters and  '
    puts 'correct order) with the least number of guesses.    '
    puts 'You will have a total of 10 pattern guesses each    '
    puts 'game. After each guess the CodeMaker will provide   '
    puts 'feedback by telling you how many guesses are correct'
    puts 'in both letter and position (o) and also how many   '
    puts 'guesses are the correct letter, but in the wrong    '
    puts 'position (x).                                       '
    puts '                                                    '
    puts 'In order to submit a pattern guess you must first   '
    puts 'enter 4 valid characters then press the [return] or '
    puts '[enter] key.                                        '
  end

  def prompt_guess(remaining_guesses)
    puts ''
    puts "You have #{remaining_guesses} guesses left."
    puts 'What is your guess?'
    prompt_input
  end

  def prompt_input
    print '> '
  end

  def feedback(feedback = '')
    puts "Guess Feedback: #{feedback}"
  end

  def goodbye
    puts 'Goodbye.'
  end
end
