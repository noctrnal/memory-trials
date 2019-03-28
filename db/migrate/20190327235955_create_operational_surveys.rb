class CreateOperationalSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :operational_surveys do |t|
      t.references :survey, foreign_key: true
      t.integer :span, default: 3

      t.timestamps
    end
  end
end
