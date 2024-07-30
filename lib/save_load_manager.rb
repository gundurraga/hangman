require 'yaml'

class SaveLoadManager
  SAVE_DIR = File.expand_path('../saved_games', __dir__)

  def initialize
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
  end

  def save(game, filename, overwrite = false)
    full_path = File.join(SAVE_DIR, "#{filename}.yml")
    return :file_exists if File.exist?(full_path) && !overwrite

    File.open(full_path, 'w') do |file|
      file.write(YAML.dump(game.to_h))
    end
    :success
  end

  def load_game(filename)
    game_data = YAML.load_file(File.join(SAVE_DIR, "#{filename}.yml"))
    Game.from_h(game_data)
  end

  def list_saved_games
    Dir.glob(File.join(SAVE_DIR, '*.yml')).map { |f| File.basename(f, '.yml') }
  end
end
