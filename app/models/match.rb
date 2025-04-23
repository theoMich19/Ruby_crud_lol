class Match < ApplicationRecord
  belongs_to :first_team, class_name: 'Team'
  belongs_to :second_team, class_name: 'Team'
  has_one :result, dependent: :destroy
  
  enum status: { upcoming: 0, completed: 1, cancelled: 2 }
end