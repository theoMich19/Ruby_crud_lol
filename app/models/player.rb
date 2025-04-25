class Player < ApplicationRecord
  belongs_to :team, optional: true

  enum role: {
    top_laner: 'Top laner',
    jungler: 'Jungler',
    mid_laner: 'Mid laner',
    adc: 'ADC',
    support: 'Support'
  }

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :role, inclusion: { in: roles.keys }, allow_nil: true
  validate :unique_full_name

  before_save :capitalize_names

  def self.without_team
    where(team_id: nil)
  end

  def formatted_role
    return 'Non défini' if role.nil?

    case role
    when 'top_laner'
      'Top Laner'
    when 'mid_laner'
      'Mid Laner'
    when 'jungler'
      'Jungler'
    when 'adc'
      'ADC'
    when 'support'
      'Support'
    end
  end

  private

  def capitalize_names
    self.last_name = last_name.capitalize if last_name.present?
    self.first_name = first_name.capitalize if first_name.present?
  end

  def unique_full_name
    return if last_name.blank? || first_name.blank?

    existing_player = Player.where(
      'LOWER(last_name) = LOWER(?) AND LOWER(first_name) = LOWER(?)',
      last_name,
      first_name
    ).where.not(id: id).first

    if existing_player
      errors.add(:base, "Un joueur avec le nom #{first_name} #{last_name} existe déjà")
    end
  end
end
