class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.text :sentence
      t.boolean :veracity

      t.timestamps
    end
  end
end
