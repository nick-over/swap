# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

WordNameSchema = Dry::Schema.Params do
  required(:word_name).filled(SchemaTypes::StrippedString, format?: /^[a-zA-Zа-яА-Я '`-]+$/)
end
