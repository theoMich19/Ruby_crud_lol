class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.references :match, null: false, foreign_key: true
      t.integer :first_team_score
      t.integer :second_team_score

      t.timestamps
    end
  end
end
