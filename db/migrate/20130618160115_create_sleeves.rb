class CreateSleeves < ActiveRecord::Migration
  def change
    create_table :sleeves do |t|
      t.string :faceValue
      t.string :suit
      t.boolean :cardUsed

      t.timestamps
    end
  end
end
