# frozen_string_literal: true

# The model of Word
class Word
  attr_accessor :name, :lang, :meanings

  def initialize(options)
    @lang = options[:lang]
    @name = options[:name]
    @meanings = if options[:meanings].nil?
                  []
                else
                  options[:meanings].map do |meaning|
                    Meaning.new(meaning)
                  end
                end
  end

  def add_meaning(meaning)
    @meanings << meaning
  end

  def add_translations(value, translations)
    translations = translations.map(&:downcase)
    meaning_by_value(value).translations.concat(translations)
  end

  def meaning_by_value(value)
    @meanings.select do |meaning|
      meaning.value.downcase == value.downcase
    end[0]
  end

  def translations_by_value(value)
    meaning = @meanings.select do |mean|
      mean.value.downcase == value.downcase
    end[0]
    return [] if meaning.nil?

    meaning.translations
  end

  def translations?
    @meanings.one? do |meaning|
      !meaning.translations.empty?
    end
  end

  def all_translations
    translations = []
    @meanings.each do |meaning|
      translations.concat(meaning.translations)
    end
    translations
  end

  def meanings_values
    @meanings.map(&:value)
  end

  def to_h
    meanings = if @meanings.empty?
                 []
               else
                 @meanings.map do |meaning|
                   [[:value, meaning.value],
                    [:synonyms, meaning.synonyms],
                    [:translations, meaning.translations]].to_h
                 end
               end
    [[:lang, @lang], [:name, @name], [:meanings, meanings]].to_h
  end
end
