# frozen_string_literal: true

# Extra class for code uniformity
class Meaning
  attr_accessor :value, :synonyms, :translations
  def initialize(options)
    @value = options[:value].downcase
    @synonyms = options[:synonyms].map(&:downcase)
    @translations = options[:translations].map(&:downcase)
  end

  def to_h
    [[:value, @value], [:synonyms, @synonyms], [:translations, @translations]].to_h
  end
end
