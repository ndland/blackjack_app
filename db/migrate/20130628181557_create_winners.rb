class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :game_id
      t.string :outcome

      t.timestamps
    end
  end
end
