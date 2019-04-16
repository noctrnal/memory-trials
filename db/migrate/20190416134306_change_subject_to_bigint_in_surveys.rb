class ChangeSubjectToBigintInSurveys < ActiveRecord::Migration[5.2]
  def change
    change_column :surveys, :subject, :bigint
  end
end
