class Result < ApplicationRecord
  belongs_to :match
  
  # Méthode pour déterminer l'équipe gagnante
  def winner
    if first_team_score > second_team_score
      match.first_team
    elsif second_team_score > first_team_score
      match.second_team
    else
      nil # Match nul
    end
  end
end