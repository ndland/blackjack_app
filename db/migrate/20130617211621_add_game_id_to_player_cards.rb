class AddGameIdToPlayerCards < ActiveRecord::Migration
  def change
    add_column :player_cards, :game_id, :integer
  end
end
