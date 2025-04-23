class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :last_name
      t.string :first_name
      t.string :role
      t.references :team, null: true, foreign_key: true

      t.timestamps
    end
  end
end
