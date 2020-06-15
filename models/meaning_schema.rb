# frozen_string_literal: true

require 'dry-schema'
require_relative 'schema_types'

MeaningSchema = Dry::Schema.Params do
  required(:meaning_value).filled(SchemaTypes::StrippedString, format?: /^[a-zA-Zа-яА-Я ёЁ,'`-]+$/)
  required(:meaning_synonyms).maybe(SchemaTypes::StrippedString,
                                    format?:
                                        /^([a-zA-Zа-яА-Я ,'`-]+;?)+[a-zA-Zа-яА-Я ёЁ,'`-]$/)
  required(:meaning_translations).filled(SchemaTypes::StrippedString,
                                         format?:
                                             /^([a-zA-Zа-яА-Я ,'`-]+;?)+[a-zA-Zа-яА-Я ёЁ,'`-]$/)
end
