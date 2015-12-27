require_relative '../lib/game'
require_relative '../lib/rules'

describe Game do
  let(:rules) {
    Rules.new
      }
  let(:player) {
    double('input',
      guess: 'temp'
    )}
  let(:code_maker) {
    double('code',
      generate: ''
    )}
  let(:validator) {
    double('feedback',
      hint: 'hint',
      correct?: nil
    )}
  let(:output) {
    double('view',
      greeting: 'hi',
      guess_prompt: 'input something',
      round_feedback: 'things happened',
      goodbye: 'fin'
    )}
  let(:game) {
      Game.new(
        input: player,
        code_maker: code_maker,
        code_checker: validator,
        view: output,
        game_rules: rules
    )}


  describe '#start' do

    it 'requests input from the player' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)

      expect(player).to receive(:guess)

      game.start
    end


    it 'provides a hint to the players last guess' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)
      allow(validator).to receive(:hint).and_return('recent hint')

      expect(output).to receive(:round_feedback).with(any_args, 'recent hint')

      game.start
    end

    it 'ends the game if a player is wrong ten times  ' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)
      expect(player).to receive(:guess).exactly(10).times
      expect(output).to receive(:goodbye)

      game.start
    end

    it 'ends the game if a player guesses correctly' do
      allow(validator).to receive(:new).with(any_args)
        .and_return(validator)
      allow(code_maker).to receive(:generate).and_return('cccc')
      allow(player).to receive(:guess).and_return('cccc')
      allow(validator).to receive(:correct?).and_return(true)

      expect(player).to receive(:guess).once
      expect(output).to receive(:goodbye)

      game.start
    end
  end
end

