# Nettoyage de la base de données
puts "Suppression des données existantes..."
Result.destroy_all
Match.destroy_all
Player.destroy_all
Team.destroy_all

# Création des équipes
puts "Création des équipes..."
team_names = ["Dragons", "Invincibles", "Piques"]
teams = {}

team_names.each do |name|
  teams[name] = Team.create!(name: name)
  puts "  Équipe créée: #{name}"
end

# Création des joueurs avec les rôles standards de League of Legends
puts "Création des joueurs..."

# Définition des rôles LoL
roles = ["Top laner", "Jungler", "Mid laner", "ADC", "Support"]

# Dragons
[
  {first_name: "Thomas", last_name: "Martin", role: roles[0]},
  {first_name: "Antoine", last_name: "Durand", role: roles[1]},
  {first_name: "Lucas", last_name: "Petit", role: roles[2]},
  {first_name: "Hugo", last_name: "Leroy", role: roles[3]},
  {first_name: "Maxime", last_name: "Moreau", role: roles[4]}
].each do |player_data|
  player = Player.create!({
    first_name: player_data[:first_name],
    last_name: player_data[:last_name],
    role: player_data[:role],
    team: teams["Dragons"]
  })
  puts "  Joueur créé: #{player.first_name} #{player.last_name} (#{player.role}, Dragons)"
end

# Invincibles
[
  {first_name: "Nicolas", last_name: "Bernard", role: roles[0]},
  {first_name: "Quentin", last_name: "Robert", role: roles[1]},
  {first_name: "Julien", last_name: "Richard", role: roles[2]},
  {first_name: "Mathieu", last_name: "Simon", role: roles[3]},
  {first_name: "Alexandre", last_name: "Laurent", role: roles[4]}
].each do |player_data|
  player = Player.create!({
    first_name: player_data[:first_name],
    last_name: player_data[:last_name],
    role: player_data[:role],
    team: teams["Invincibles"]
  })
  puts "  Joueur créé: #{player.first_name} #{player.last_name} (#{player.role}, Invincibles)"
end

# Piques
[
  {first_name: "Romain", last_name: "Michel", role: roles[0]},
  {first_name: "David", last_name: "Lefebvre", role: roles[1]},
  {first_name: "Pierre", last_name: "Garcia", role: roles[2]},
  {first_name: "Adrien", last_name: "Dupont", role: roles[3]},
  {first_name: "Vincent", last_name: "Gauthier", role: roles[4]}
].each do |player_data|
  player = Player.create!({
    first_name: player_data[:first_name],
    last_name: player_data[:last_name],
    role: player_data[:role],
    team: teams["Piques"]
  })
  puts "  Joueur créé: #{player.first_name} #{player.last_name} (#{player.role}, Piques)"
end

# Création des matchs entre chaque équipe
puts "Création des matchs..."

matches = [
  # Match 1: Dragons vs Invincibles (Terminé)
  {
    first_team: teams["Dragons"], 
    second_team: teams["Invincibles"], 
    date: DateTime.new(2025, 4, 15, 18, 0), 
    status: :completed # Match terminé
  },
  
  # Match 2: Dragons vs Piques (En cours)
  {
    first_team: teams["Dragons"], 
    second_team: teams["Piques"], 
    date: DateTime.new(2025, 4, 16, 19, 0), 
    status: :in_progress # Match en cours
  },
  
  # Match 3: Invincibles vs Piques (À venir)
  {
    first_team: teams["Invincibles"], 
    second_team: teams["Piques"], 
    date: DateTime.new(2025, 4, 25, 20, 0), 
    status: :upcoming # Match à venir
  }
]

created_matches = []
matches.each do |match_data|
  match = Match.create!(match_data)
  created_matches << match
  puts "  Match créé: #{match.first_team.name} vs #{match.second_team.name} le #{match.date.strftime('%d/%m/%Y à %H:%M')} (#{match.status})"
end

# Création de résultats pour les matchs terminés
puts "Création des résultats..."

# Résultat pour le match Dragons vs Invincibles
result = Result.create!({
  match: created_matches[0],
  first_team_score: 3,
  second_team_score: 1
})
puts "  Résultat créé: #{result.match.first_team.name} #{result.first_team_score} - #{result.second_team_score} #{result.match.second_team.name}"

puts "Seed terminé avec succès!"