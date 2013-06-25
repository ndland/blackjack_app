class CreateDealerCards < ActiveRecord::Migration
  def change
    create_table :dealer_cards do |t|
      t.string :faceValue
      t.string :suit
      t.integer :game_id

      t.timestamps
    end
  end
end
