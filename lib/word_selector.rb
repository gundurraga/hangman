class WordSelector
  def initialize(dictionary_path = '../google-10000-english-no-swears.txt')
    @dictionary_path = File.expand_path(dictionary_path, __dir__)
    @words = []
    load_dictionary
  end

  def load_dictionary
    puts "Attempting to load dictionary from: #{@dictionary_path}"
    File.readlines(@dictionary_path).each do |line|
      word = line.chomp
      @words << word if word.length >= 5
    end
    puts "Successfully loaded #{@words.size} words"
  rescue Errno::ENOENT
    puts "Error: Dictionary file not found at #{@dictionary_path}"
    exit
  end

  def select_word
    @words.sample
  end
end

if __FILE__ == $0
  selector = WordSelector.new
  puts 'First 5 words:'
  5.times do
    puts selector.select_word
  end
end
