class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :health
      t.integer :power

      t.timestamps
    end
  end
end
