class Board < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :body,  presence: true, length: { maximum: 6_5535 }
end
