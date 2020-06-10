# frozen_string_literal: true

# The list class of words with current language
class WordList
  attr_accessor :cur_lang

  def initialize(word_list = [], cur_lang = LangValue::RUS)
    @word_list = word_list.map do |word|
      [{ name: word.name, lang: word.lang }, word]
    end.to_h
    @cur_lang = cur_lang.downcase
  end

  def word_by_name(name)
    @word_list[{ name: name, lang: @cur_lang }]
  end

  def add_word(word)
    @word_list[{ name: word.name, lang: word.lang }] = word
  end

  def words_by_chars(chars)
    all_words_by_cur_lang.select do |word|
      word.name.include?(chars)
    end
  end

  def words_without_translation
    all_words_by_cur_lang.reject(&:translations?)
  end

  def all_words_by_cur_lang
    all_words.select { |word| word.lang.downcase == @cur_lang.downcase }
  end

  def translation_homonyms?(word1, word2)
    translations1 = word1.all_translations
    translations2 = word2.all_translations
    translations1.one? do |translation|
      translations2.one? { |tr| tr.downcase == translation.downcase }
    end
  end

  def all_words
    @word_list.values
  end
end
