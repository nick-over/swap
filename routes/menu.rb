# frozen_string_literal: true

# Routes for the cool books of this application
class TranslatorApplication
  path :menu, '/menu'

  hash_branch('menu') do |r|
    append_view_subdir('menu')
    set_layout_options(template: '../views/layout')

    r.is do
    end
  end
end
