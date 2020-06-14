# frozen_string_literal: true

# The list class of words with current language
class WordList
  attr_accessor :cur_lang

  def initialize(word_list = [], cur_lang = LangValue::RUS)
    @word_list = word_list.map do |word|
      [{ name: word.name, lang: word.lang }, word]
    end.to_h
    @cur_lang = cur_lang
  end

  def word_by_name(name, lang = @cur_lang)
    @word_list[{ name: name.downcase, lang: lang }]
  end

  def add_word(word)
    word.name.downcase!
    @word_list[{ name: word.name, lang: word.lang }] = word
  end

  def words_by_chars(chars)
    all_words_by_cur_lang.select do |word|
      word.name.include?(chars.downcase)
    end
  end

  def words_without_translation
    all_words_by_cur_lang.reject(&:translations?)
  end

  def all_words_by_cur_lang
    all_words.select { |word| word.lang == @cur_lang }
  end

  def translation_homonyms?(word1, word2)
    return nil if word1.nil? || word2.nil?

    translations1 = word1.all_translations
    translations2 = word2.all_translations
    translations1.any? do |translation|
      translations2.any? { |tr| tr == translation }
    end
  end

  def all_words
    @word_list.values
  end
end
