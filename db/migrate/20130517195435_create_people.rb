class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.integer :credits
      t.integer :level

      t.timestamps
    end
  end
end
