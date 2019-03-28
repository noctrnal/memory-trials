class CreateReadingSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :reading_surveys do |t|
      t.references :survey, foreign_key: true
      t.integer :span

      t.timestamps
    end
  end
end
