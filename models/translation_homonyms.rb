# frozen_string_literal: true

require 'dry-schema'
require_relative 'schema_types'

TranslationHomonymsSchema = Dry::Schema.Params do
  required(:word_name1).filled(SchemaTypes::StrippedString)
  required(:word_name2).filled(SchemaTypes::StrippedString)
end
