class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body,  presence: true, length: { maximum: 65_535 }

  def bookmark(user)
    Bookmark.create(user_id: user.id)
  end

  def unbookmark(user)
    Bookmark.find(user_id: user.id).destroy
  end

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
