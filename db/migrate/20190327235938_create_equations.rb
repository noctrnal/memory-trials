class CreateEquations < ActiveRecord::Migration[5.2]
  def change
    create_table :equations do |t|
      t.text :equation
      t.boolean :veracity

      t.timestamps
    end
  end
end
