class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :faceValue
      t.boolean :cardUsed
      t.integer :order

      t.timestamps
    end
  end
end
