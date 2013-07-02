class CreateGameLists < ActiveRecord::Migration
  def change
    create_table :game_lists do |t|
      t.integer :user_id
      t.integer :table_id
      t.integer :bet_amount

      t.timestamps
    end
  end
end
