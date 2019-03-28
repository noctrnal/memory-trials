class CreateReadingQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :reading_questions do |t|
      t.references :reading_survey, foreign_key: true
      t.integer :memory
      t.integer :recall
      t.boolean :veracity
      t.references :sentence, foreign_key: true

      t.timestamps
    end
  end
end
