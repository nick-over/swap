# frozen_string_literal: true

require 'forme'
require 'roda'

require_relative 'models'

# The main application class
class TranslatorApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :hash_routes
  plugin :path
  plugin :render
  plugin :status_handler
  plugin :view_options

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  require_relative 'routes/menu.rb'
  require_relative 'routes/words.rb'

  opts[:words] = Store.new.word_list
  status_handler(404) do
    view('not_found')
  end

  route do |r|
    @options = {}
    @cur_lang = opts[:words].cur_lang
    r.public if opts[:serve_static]
    r.hash_branches

    r.root do
      r.redirect menu_path
    end
  end
end
