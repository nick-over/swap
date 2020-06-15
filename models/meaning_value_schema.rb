# frozen_string_literal: true

require 'dry-schema'
require_relative '../models/schema_types'

MeaningValueSchema = Dry::Schema.Params do
  required(:meaning_value).filled(SchemaTypes::StrippedString, format?: /^[a-zA-Zа-яА-Я ёЁ,'`-]+$/)
end
