class AddEquationToOperationalQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :operational_questions, :equation, foreign_key: true
  end
end
