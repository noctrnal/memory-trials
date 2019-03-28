class Survey < ApplicationRecord
  has_many :operational_surveys, inverse_of: :survey, dependent: :destroy
  has_many :reading_surveys, inverse_of: :survey, dependent: :destroy

  has_many :operational_questions, through: :operational_surveys
  has_many :reading_questions, through: :reading_surveys

  has_many :equations, through: :operational_questions
  has_many :sentences, through: :reading_questions
end
