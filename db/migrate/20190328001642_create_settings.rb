class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :delay
      t.integer :maximum_value
      t.integer :minimum_value
      t.integer :surveys

      t.timestamps
    end
  end
end
