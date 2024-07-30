require_relative 'word_selector'

class Game
  attr_reader :secret_word, :guessed_letters, :remaining_attempts, :incorrect_guesses
  attr_accessor :saved

  def initialize
    @word_selector = WordSelector.new
    @secret_word = @word_selector.select_word
    @guessed_letters = []
    @incorrect_guesses = 0
    @remaining_attempts = 8
    @saved = false
  end

  def make_guess(letter)
    letter = letter.downcase
    return { status: :already_guessed } if @guessed_letters.include?(letter)

    @guessed_letters << letter

    if @secret_word.include?(letter)
      { status: :correct }
    else
      @incorrect_guesses += 1
      @remaining_attempts -= 1
      { status: :incorrect, remaining_attempts: @remaining_attempts }
    end
  end

  def word_state
    @secret_word.chars.map { |char| @guessed_letters.include?(char) ? char : '_' }.join(' ')
  end

  def won?
    @secret_word.chars.all? { |char| @guessed_letters.include?(char) }
  end

  def lost?
    @remaining_attempts <= 0
  end

  def game_over?
    won? || lost?
  end

  def to_h
    {
      secret_word: @secret_word,
      guessed_letters: @guessed_letters,
      incorrect_guesses: @incorrect_guesses,
      remaining_attempts: @remaining_attempts
    }
  end

  def self.from_h(hash)
    game = new
    game.instance_variable_set(:@secret_word, hash[:secret_word])
    game.instance_variable_set(:@guessed_letters, hash[:guessed_letters])
    game.instance_variable_set(:@incorrect_guesses, hash[:incorrect_guesses])
    game.instance_variable_set(:@remaining_attempts, hash[:remaining_attempts])
    game.saved = true
    game
  end
end
