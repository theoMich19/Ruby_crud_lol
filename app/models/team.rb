class Team < ApplicationRecord
    has_many :players, dependent: :destroy
    
    # Un match peut avoir cette équipe soit comme first_team soit comme second_team
    has_many :home_matches, class_name: 'Match', foreign_key: 'first_team_id'
    has_many :away_matches, class_name: 'Match', foreign_key: 'second_team_id'
    
    validates :name, presence: true, uniqueness: true
    
    def full?
      players.count >= 5
    end
    
    # Méthode pour obtenir tous les matchs d'une équipe
    def matches
      Match.where('first_team_id = ? OR second_team_id = ?', id, id)
    end
  end