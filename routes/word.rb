# frozen_string_literal: true

# Routes for the menu of this application
class TranslatorApplication
  path Word do |word, action|
    if action
      WEBrick::HTTPUtils.escape("/word/#{word.name}/#{action}")
    else
      WEBrick::HTTPUtils.escape("/word/#{word.name}")
    end
  end

  hash_branch('word') do |r|
    append_view_subdir('word')
    set_layout_options(template: '../views/layout')

    r.on String do |raw_word_name|
      word_name = CGI.unescape(raw_word_name)
      @word = opts[:words].word_by_name(word_name)
      @options = DryResultFormeWrapper.new(WordNameSchema.call({ word_name: word_name }))
      next if @options.failure? || @word.nil?

      r.is do
        view('word')
      end
      r.on 'new_meaning' do
        r.get do
          view('new_meaning')
        end
        r.post do
          @options = DryResultFormeWrapper.new(MeaningSchema.call(r.params))
          if @options.success?
            @word.add_meaning(Meaning.new({
                                            value: @options[:meaning_value],
                                            synonyms: @options[:meaning_synonyms].split(','),
                                            translations: @options[:meaning_translations].split(',')
                                          }))
            r.redirect(path(@word))
          end
          view('new_meaning')
        end
      end
      r.on 'new_translation' do
        r.get do
          view('new_translation')
        end
        r.post do
          @options = DryResultFormeWrapper.new(TranslationSchema.call(r.params))
          if @options.success?
            @word.add_translations(@options[:meaning_value],
                                   @options[:meaning_translations].split(','))
            r.redirect(path(@word))
          end
          view('new_translation')
        end
      end
      r.is 'translation' do
        @translations = []
        r.get do
          @options = {}
          view('translation')
        end
        r.post do
          @options = DryResultFormeWrapper.new(MeaningValueSchema.call(r.params))
          if @options.success?
            @value = @options[:meaning_value]
            @translations = @word.translations_by_value(@value)
          end
          view('translation')
        end
      end
    end
  end
end
