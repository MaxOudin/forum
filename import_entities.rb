require 'csv'

def create_organisme(row)
  case row["Type"]
  when "3503"
    InstitutionUe.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3504"
    InstitutionPubliqueMalgache.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3505"
    InstitutionFinancement.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3507"
    OrganisationMultilaterale.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3508"
    OngFondationInternationale.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3509"
    OrganisationSocieteCivileMalgache.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3510"
    UniversiteCentreRecherche.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3511"
    EntrepriseSecteurPrive.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  when "3512"
    Autre.create(
      name: row["Organism Name"].to_s,
      description: row["Description"].to_s,
      internal_code: row["Type"].to_s
    )
  else
    puts "Type d'organisme inconnu"
  end
end

# Chemin vers le fichier CSV
csv_file = "db/export_entity_type.csv"

# Lire le fichier CSV et créer des instances d'organismes
CSV.foreach(csv_file, headers: true, col_sep: ";") do |row|
  create_organisme(row)
end
