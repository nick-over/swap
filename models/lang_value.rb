# frozen_string_literal: true

# Languages module
module LangValue
  ENG = 'английский'
  RUS = 'русский'

  def self.all_langs
    [ENG, RUS]
  end

  def self.get_lang_by_match(match)
    if !match.match(/[а-яА-Я ёЁ]/).nil?
      RUS
    else
      ENG
    end
  end

  def self.get_another_lang(lang)
    all_langs.reject { |cur| cur == lang }[0]
  end
end
