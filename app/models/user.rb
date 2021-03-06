class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :blog_comments, dependent: :destroy


  # 被フォロー関係を通じて参照→followed_idをフォローしているユーザー
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # foreign_key: "followed_id"でどのカラムを参照して欲しいのかを定義
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 与フォロー関係を通じて参照→follower_idをフォローしているユーザー
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def full_name
    self.last_name. + " " + self.first_name
  end

  def full_kana_name
    self.kana_last_name + " " + self.kana_first_name
  end

end
