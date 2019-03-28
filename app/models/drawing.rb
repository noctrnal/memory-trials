class Drawing < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
