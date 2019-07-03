class OperationalSurvey < ApplicationRecord
  belongs_to :survey
  has_many :operational_questions, inverse_of: :operational_survey, dependent: :destroy

  accepts_nested_attributes_for :operational_questions

  def completed?
    operational_questions.count == 81 ? true : false
  end
end
