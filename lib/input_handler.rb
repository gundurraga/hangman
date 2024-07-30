require 'colorize'

class InputHandler
  def self.get_menu_choice
    puts 'Welcome to Hangman!'.colorize(:cyan)
    puts '1. New Game'
    puts '2. Load Game'
    gets.chomp
  end

  def self.get_game_input
    print "Enter a letter (or 'save' to save the game, 'exit' to quit): ".colorize(:yellow)
    gets.chomp.downcase
  end

  def self.get_save_confirmation
    print 'Game not saved. Do you want to save before exiting? (y/n): '.colorize(:yellow)
    gets.chomp.downcase
  end

  def self.get_save_name
    print 'Enter a name for your saved game: '.colorize(:green)
    gets.chomp
  end

  def self.get_load_game_choice(saved_games)
    puts 'Saved games:'.colorize(:green)
    saved_games.each_with_index { |name, index| puts "#{index + 1}. #{name}" }
    print 'Enter the number of the game to load: '
    gets.chomp.to_i - 1
  end

  def self.get_overwrite_confirmation(filename)
    print "A save file named '#{filename}' already exists. Do you want to overwrite it? (y/n): ".colorize(:yellow)
    gets.chomp.downcase
  end
end
