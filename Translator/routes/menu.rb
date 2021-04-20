# frozen_string_literal: true

# Routes for the menu of this application
class TranslatorApplication
  path :menu, '/menu'

  hash_branch('menu') do |r|
    append_view_subdir('menu')
    set_layout_options(template: '../views/layout')
    r.is do
      r.get do
        @options = { cur_lang: opts[:words].cur_lang }
        view('menu')
      end
      r.post do
        @options = DryResultFormeWrapper.new(LangValueSchema.call(r.params))
        if @options.success?
          opts[:words].cur_lang = @options[:cur_lang]
          @cur_lang = opts[:words].cur_lang
        end
        view('menu')
      end
    end
  end
end
