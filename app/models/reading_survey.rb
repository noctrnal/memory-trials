class ReadingSurvey < ApplicationRecord
  belongs_to :survey
  has_many :reading_questions, inverse_of: :reading_survey, dependent: :destroy

  accepts_nested_attributes_for :reading_questions
end
