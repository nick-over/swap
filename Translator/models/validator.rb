# frozen_string_literal: true

# Extra validator for words model
class Validator
  def self.check_words_name_in_db(word_name1, word_name2, db)
    errors = [].concat(check_word_name_in_db(word_name1, db))
               .concat(check_word_name_in_db(word_name2, db))
    {
      word_name1: word_name1,
      word_name2: word_name2,
      errors: errors
    }
  end

  def self.check_word_name_in_db(word_name, db)
    word = db.word_by_name(word_name)
    messages = []
    if word.nil?
      messages << "Слово #{word_name} отсутствует в нашей базе данных"
    elsif word.meanings.empty?
      messages << "Перевод для слова #{word_name} отсутствует в нашей базе"
    end
    messages
  end
end
