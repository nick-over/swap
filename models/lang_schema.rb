# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'lang_value'

LangValueSchema = Dry::Schema.Params do
  required(:cur_lang).filled(SchemaTypes::StrippedString, included_in?: LangValue.all_langs)
end
