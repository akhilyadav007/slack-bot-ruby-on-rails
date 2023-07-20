class App < ApplicationRecord
  validates :slack_id, presence: true
  validates :access_token, presence: true

  has_many :incidents   
end
