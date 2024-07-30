require_relative 'game'
require_relative 'display'
require_relative 'save_load_manager'
require_relative 'input_handler'
require 'colorize'

def save_game_process(game, save_load_manager)
  loop do
    save_name = InputHandler.get_save_name
    result = save_load_manager.save(game, save_name)

    case result
    when :success
      game.saved = true
      puts 'Game saved successfully!'.colorize(:green)
      return
    when :file_exists
      overwrite = InputHandler.get_overwrite_confirmation(save_name)
      if overwrite == 'y'
        result = save_load_manager.save(game, save_name, true)
        if result == :success
          game.saved = true
          puts 'Game saved successfully!'.colorize(:green)
          return
        else
          puts 'An error occurred while saving the game.'.colorize(:red)
        end
      end
      # If user doesn't want to overwrite, the loop continues and asks for a new filename
    end
  end
end

def play_game(game, save_load_manager)
  display = Display.new(game)

  until game.game_over?
    display.show_game_state
    input = InputHandler.get_game_input

    case input
    when 'save'
      save_game_process(game, save_load_manager)
    when 'exit'
      save_game_process(game, save_load_manager) if !game.saved && (InputHandler.get_save_confirmation == 'y')
      puts 'Thanks for playing Hangman!'.colorize(:cyan)
      exit
    when /^[a-z]$/
      result = game.make_guess(input)
      game.saved = false
      case result[:status]
      when :correct
        puts 'Correct guess!'.colorize(:green)
      when :incorrect
        puts 'Incorrect guess!'.colorize(:red)
      when :already_guessed
        puts "You've already guessed that letter.".colorize(:yellow)
      end
    else
      puts "Invalid input. Please enter a single letter, 'save', or 'exit'.".colorize(:red)
    end

    sleep(1)
  end

  display.show_game_state
end

save_load_manager = SaveLoadManager.new

choice = InputHandler.get_menu_choice

if choice == '2'
  saved_games = save_load_manager.list_saved_games
  if saved_games.empty?
    puts 'No saved games found. Starting a new game.'.colorize(:yellow)
    game = Game.new
  else
    game_choice = InputHandler.get_load_game_choice(saved_games)
    game = save_load_manager.load_game(saved_games[game_choice])
  end
else
  game = Game.new
end

play_game(game, save_load_manager)
