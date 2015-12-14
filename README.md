# Mastermind
Think you can crack it?

## Configuration
Clone the repo, navigate to the main directory, and execute:
```
bundle install
```
Start the game with:
```
ruby runner.rb
```

## Running Tests
Navigate to the main directory and enter:
```
rspec
```

## Game Instructions
A random code will be generated; consisting of 4 of the following letters: A, B, C, D, E, F. Your job is to break the code (correct letters in the correct order). You will have a total of 10 attempts each game. After each guess you will recieve feedback consisting of how many guesses are correct in both letter and position and also how many guesses are the correct letter, but in the wrong position.

In order to submit a guess you must first enter 4 valid characters then press the [return] or [enter] key.

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
