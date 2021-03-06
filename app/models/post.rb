class Post < ApplicationRecord

  has_one_attached :post_image

  belongs_to :user, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :tags, dependent: :destroy

  def liked_by(user)
    likes.where(user_id: user.id).exists?
  end

  validates :post_image, presence: true, blob: { content_type: :image }
  validates :title, presence: true
  validates :text, presence: true

end
