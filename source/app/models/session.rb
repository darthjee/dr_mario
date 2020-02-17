class Session < ApplicationRecord
  scope :valid, -> { where("expiration IS NULL OR expiration > ?", Time.now) }

  belongs_to :user
end
