class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.integer :subject
      t.boolean :initial_instructions, default: true
      t.boolean :operational_instructions, default: true
      t.boolean :reading_instructions, default: true

      t.timestamps
    end
  end
end
