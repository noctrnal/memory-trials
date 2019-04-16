class ChangeSubjectToBigintInDrawings < ActiveRecord::Migration[5.2]
  def change
    change_column :drawings, :subject, :bigint
  end
end
