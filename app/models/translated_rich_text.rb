# app/models/translated_rich_text.rb
class TranslatedRichText < ApplicationRecord
  belongs_to :record, polymorphic: true
  has_rich_text :body

  validates :locale, presence: true
  validates :field_name, presence: true
  validates :locale, uniqueness: { scope: [:record_id, :record_type, :field_name] }
end
