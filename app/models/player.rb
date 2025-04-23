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

  before_save :capitalize_names

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
end
