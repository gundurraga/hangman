require 'colorize'

class Display
  HANGMAN_STATES = [
    '' + "






    =========
    " + '',
    '' + "
      +---+
      |   |
          |
          |
          |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      O   |
          |
          |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      O   |
      |   |
          |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      O   |
     /|   |
          |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      O   |
     /|\\  |
          |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      O   |
     /|\\  |
     /    |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      O   |
     /|\\  |
     / \\  |
          |
    =========
    " + '',
    '' + "
      +---+
      |   |
      X   |
     /|\\  |
     / \\  |
          |
    =========
    " + ''
  ]

  def initialize(game)
    @game = game
  end

  def show_game_state
    clear_screen
    puts HANGMAN_STATES[@game.incorrect_guesses].colorize(:yellow)
    puts "\nWord: #{@game.word_state}".colorize(:cyan)
    puts "Incorrect Guesses: #{@game.incorrect_guesses}".colorize(:red)
    puts "Guessed Letters: #{@game.guessed_letters.join(', ')}".colorize(:green)
    puts "\n#{game_status}"
  end

  private

  def clear_screen
    system('clear') || system('cls')
  end

  def game_status
    if @game.won?
      "Congratulations! You've guessed the word: #{@game.secret_word}".colorize(:green)
    elsif @game.lost?
      "Game Over! The word was: #{@game.secret_word}".colorize(:red)
    else
      "You have #{@game.remaining_attempts} attempts left.".colorize(:yellow)
    end
  end
end
