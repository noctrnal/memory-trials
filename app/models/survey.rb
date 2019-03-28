class Survey < ApplicationRecord
  has_many :operational_surveys, inverse_of: :survey, dependent: :destroy
end
