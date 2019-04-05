class AddSubjectToDrawing < ActiveRecord::Migration[5.2]
  def change
    add_column :drawings, :subject, :integer
  end
end
