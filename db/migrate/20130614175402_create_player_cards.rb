class CreatePlayerCards < ActiveRecord::Migration
  def change
    create_table :player_cards do |t|
      t.string :suit
      t.string :faceValue

      t.timestamps
    end
  end
end
