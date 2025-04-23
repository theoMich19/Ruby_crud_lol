# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Suppression des données existantes
puts "Nettoyage de la base de données..."
Result.destroy_all
Match.destroy_all
Player.destroy_all
Team.destroy_all

# Création des équipes
puts "Création des équipes..."
team_names = ["Invincibles", "Dragons", "Piques", "Maestros", "Eclipse"]
teams = {}

team_names.each do |name|
  team = Team.create!(name: name)
  teams[name] = team
  puts "  Équipe créée: #{team.name}"
end

# Création des joueurs
puts "Création des joueurs..."
roles = ["Top laner", "Jungler", "Mid laner", "ADC", "Support"]

players_data = [
  # Invincibles
  {first_name: "Jean", last_name: "Dujardin", role: "Top laner", team: teams["Invincibles"]},
  {first_name: "Pierre", last_name: "Martin", role: "Jungler", team: teams["Invincibles"]},
  {first_name: "Lucas", last_name: "Bernard", role: "Mid laner", team: teams["Invincibles"]},
  {first_name: "Thomas", last_name: "Dubois", role: "ADC", team: teams["Invincibles"]},
  {first_name: "Nicolas", last_name: "Robert", role: "Support", team: teams["Invincibles"]},
  
  # Dragons
  {first_name: "Maxime", last_name: "Leroy", role: "Top laner", team: teams["Dragons"]},
  {first_name: "Alexandre", last_name: "Moreau", role: "Jungler", team: teams["Dragons"]},
  {first_name: "Julien", last_name: "Fournier", role: "Mid laner", team: teams["Dragons"]},
  {first_name: "Antoine", last_name: "Girard", role: "ADC", team: teams["Dragons"]},
  {first_name: "Victor", last_name: "Dupont", role: "Support", team: teams["Dragons"]},
  
  # Piques
  {first_name: "Hugo", last_name: "Lambert", role: "Top laner", team: teams["Piques"]},
  {first_name: "Baptiste", last_name: "Fontaine", role: "Jungler", team: teams["Piques"]},
  {first_name: "Raphaël", last_name: "Rousseau", role: "Mid laner", team: teams["Piques"]},
  {first_name: "Samuel", last_name: "Vincent", role: "ADC", team: teams["Piques"]},
  {first_name: "Gabriel", last_name: "Müller", role: "Support", team: teams["Piques"]},
  
  # Maestros
  {first_name: "Louis", last_name: "Lefebvre", role: "Top laner", team: teams["Maestros"]},
  {first_name: "Etienne", last_name: "Mercier", role: "Jungler", team: teams["Maestros"]},
  {first_name: "Mathieu", last_name: "Blanc", role: "Mid laner", team: teams["Maestros"]},
  {first_name: "Romain", last_name: "Guerin", role: "ADC", team: teams["Maestros"]},
  {first_name: "Clément", last_name: "Chevalier", role: "Support", team: teams["Maestros"]},
  
  # Eclipse
  {first_name: "Valentin", last_name: "Roy", role: "Top laner", team: teams["Eclipse"]},
  {first_name: "Jérémy", last_name: "Gautier", role: "Jungler", team: teams["Eclipse"]},
  {first_name: "Adrien", last_name: "Roux", role: "Mid laner", team: teams["Eclipse"]},
  {first_name: "Simon", last_name: "Morel", role: "ADC", team: teams["Eclipse"]},
  {first_name: "Florian", last_name: "Perrin", role: "Support", team: teams["Eclipse"]}
]

players_data.each do |player_data|
  player = Player.create!(player_data)
  puts "  Joueur créé: #{player.first_name} #{player.last_name} (#{player.role}, #{player.team.name})"
end

# Création des matchs
puts "Création des matchs..."
matches_data = [
  # Match 1 (terminé)
  {
    first_team: teams["Invincibles"], 
    second_team: teams["Dragons"], 
    date: DateTime.new(2024, 4, 15, 18, 0), 
    status: 1 # Match terminé
  },
  # Match 2 (terminé)
  {
    first_team: teams["Piques"], 
    second_team: teams["Eclipse"], 
    date: DateTime.new(2024, 4, 16, 20, 0), 
    status: 1 # Match terminé
  },
  # Match 3 (à venir, en attente de résultat)
  {
    first_team: teams["Maestros"], 
    second_team: teams["Dragons"], 
    date: DateTime.new(2024, 4, 25, 19, 0), 
    status: 0 # Match à venir
  }
]

created_matches = []
matches_data.each do |match_data|
  match = Match.create!(match_data)
  created_matches << match
  puts "  Match créé: #{match.first_team.name} vs #{match.second_team.name} le #{match.date.strftime('%d/%m/%Y à %H:%M')}"
end

# Création des résultats pour les 2 premiers matchs seulement
puts "Création des résultats..."
results_data = [
  # Résultat match 1 (Invincibles vs Dragons)
  {
    match: created_matches[0],
    first_team_score: 3,
    second_team_score: 1
  },
  # Résultat match 2 (Piques vs Eclipse)
  {
    match: created_matches[1],
    first_team_score: 0,
    second_team_score: 2
  }
]

results_data.each do |result_data|
  result = Result.create!(result_data)
  puts "  Résultat créé: #{result.match.first_team.name} #{result.first_team_score} - #{result.second_team_score} #{result.match.second_team.name}"
end

puts "Seed terminé avec succès!"