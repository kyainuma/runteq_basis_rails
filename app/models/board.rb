class Board < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 255 }
  validates :body, presence: true, length: { maximum: 65535 }
end
