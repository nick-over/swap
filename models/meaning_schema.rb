# frozen_string_literal: true

require 'dry-schema'
require_relative 'schema_types'

MeaningSchema = Dry::Schema.Params do
  required(:meaning_value).filled(SchemaTypes::StrippedString)
  required(:meaning_synonyms).filled(SchemaTypes::StrippedString,
                                     format?: /([a-zA-Zа-яА-Я '`-]+,?)+[a-zA-Zа-яА-Я]/)
  required(:meaning_translations).filled(SchemaTypes::StrippedString,
                                         format?: /([a-zA-Zа-яА-Я '`-]+,?)+[a-zA-Zа-яА-Я]/)
end
