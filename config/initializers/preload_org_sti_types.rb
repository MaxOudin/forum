# Preload STI types for Organisme
Rails.application.config.to_prepare do
  Dir[Rails.root.join('app/organismes/*.rb')].each { |file| require_dependency file }
end
