class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.datetime :date
      t.string :location
      t.references :team_first, null: false, foreign_key: { to_table: :teams }
      t.references :team_second, null: false, foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
