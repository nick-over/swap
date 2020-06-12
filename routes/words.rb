# frozen_string_literal: true

# Routes for the words of this application
class TranslatorApplication
  path :words do |action|
    if action
      WEBrick::HTTPUtils.escape("/words/#{action}")
    else
      WEBrick::HTTPUtils.escape('/words')
    end
  end

  hash_branch('words') do |r|
    append_view_subdir('words')
    set_layout_options(template: '../views/layout')
    r.is do
      r.get do
        @words = nil
        view('words')
      end
      r.post do
        @options = DryResultFormeWrapper.new(WordNameSchema.call(r.params))
        @words = opts[:words].words_by_chars(@options[:word_name]) if @options.success?
        view('words')
      end
    end
    r.is 'unknown_translations' do
      @words = opts[:words].words_without_translation
      view('unknown_translations')
    end
    r.is 'translation_homonyms' do
      @options = {}
      @errors = []
      r.get do
        view('translation_homonyms')
      end
      r.post do
        @options = DryResultFormeWrapper.new(TranslationHomonymsSchema.call(r.params))
        if @options.success?
          @errors = Validator.check_words_name_in_db(@options[:word_name1],
                                                     @options[:word_name2],
                                                     opts[:words])[:errors]
          @word1 = opts[:words].word_by_name(@options[:word_name1])
          @word2 = opts[:words].word_by_name(@options[:word_name2])
          @translation_homonyms = opts[:words].translation_homonyms?(@word1, @word2)
        end
        view('translation_homonyms')
      end
    end
    r.is 'new' do
      r.get do
        view('new_word')
      end
      r.post do
        @options = DryResultFormeWrapper.new(WordNameSchema.call(r.params))
        word_name = @options[:word_name]
        puts word_name.encoding
        if @options.success?
          @word = Word.new(name: word_name, lang: @cur_lang)
          opts[:words].add_word(@word)
          r.redirect(path(@word))
        else
          view('new_word')
        end
      end
    end
  end
end
