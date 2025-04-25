class Match < ApplicationRecord
  belongs_to :first_team, class_name: 'Team'
  belongs_to :second_team, class_name: 'Team'
  has_one :result, dependent: :destroy
  
  enum status: { upcoming: 0, in_progress: 1, completed: 2, cancelled: 3 }

  validate :different_teams

  before_validation :clear_date_if_teams_invalid

  def teams_are_valid?
    first_team&.players&.any? && second_team&.players&.any?
  end

  def can_start?
    date.present? && upcoming?
  end

  def in_progress!
    update!(status: :in_progress)
  end

  def completed!
    update!(status: :completed)
  end

  private

  def different_teams
    if first_team_id == second_team_id && first_team_id.present?
      errors.add(:base, "Les deux équipes doivent être différentes")
    end
  end

  def clear_date_if_teams_invalid
    self.date = nil unless teams_are_valid?
  end
end