# app/models/concerns/translatable_rich_text.rb
module TranslatableRichText
  extend ActiveSupport::Concern

  class_methods do
    def has_translated_rich_text(field_name)
      extend Mobility

      # Configuration Mobility classique pour le champ
      translates field_name, type: :string

      # Association avec ActionText
      has_many :translated_rich_texts, as: :record, class_name: 'TranslatedRichText', dependent: :destroy

      # Définition des méthodes d'accès
      I18n.available_locales.each do |locale|
        define_method("#{field_name}_#{locale}") do
          translated_rich_texts.find_by(field_name: field_name, locale: locale)&.body
        end

        define_method("#{field_name}_#{locale}=") do |content|
          rich_text = translated_rich_texts.find_or_initialize_by(
            field_name: field_name,
            locale: locale
          )
          rich_text.body = content
          rich_text.save
        end
      end

      # Helper pour accéder au contenu dans la locale courante
      define_method(field_name) do
        public_send("#{field_name}_#{I18n.locale}")
      end

      define_method("#{field_name}=") do |content|
        public_send("#{field_name}_#{I18n.locale}=", content)
      end
    end
  end
end
