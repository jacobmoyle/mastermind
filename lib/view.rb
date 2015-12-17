class View
  def greeting
    puts '                 Welcome MasterMind                 '
    puts '                    INSTRUCTIONS                    '
    puts 'The CodeMaker will generate a random pattern        '
    puts 'with 4 of the following letters: A, B, C, D, E, F.  '
    puts 'Your job is to break the code (correct letters and  '
    puts 'correct order) with the least number of guesses.    '
    puts '                                                    '
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
    puts '                                                    '
  end

  def guess_prompt
    puts 'What is your guess?'
    print '> '
  end

  def round_feedback(turns, feedback)
    puts ''
    puts "You have #{turns} guesses left."
    puts "Guess Feedback: #{feedback}"
  end

  def goodbye
    puts 'Thanks for playing!'
  end
end
