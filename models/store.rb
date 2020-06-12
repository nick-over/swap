# frozen_string_literal: true

require 'psych'
require_relative 'word_list'
require_relative 'word'
require_relative 'meaning'

# Storage for all of our data
class Store
  attr_reader :word_list

  DATA_STORE = File.expand_path('../db/words.yaml', __dir__)

  def initialize
    @word_list = WordList.new
    read_data
    at_exit { write_data }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:word_list].each do |raw_word|
      @word_list.add_word(Word.new(raw_word))
    end
  end

  def write_data
    raw_words = @word_list.all_words.map(&:to_h)
    yaml_data = Psych.dump({
                             word_list: raw_words
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
