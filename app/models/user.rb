class User < ApplicationRecord
  #メールアドレスを小文字に変換する
  before_save { self.email.downcase! }
  #Usernameは最大長は50とする
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  #アソシエーション
  has_many :posts
  has_many :follows
  has_many :followings, through: :follows, source: :follow
  has_many :reverses, class_name: 'Follow', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses, source: :user

 
 def follow(other_user)
    #フォローしようとしているユーザが自分ではないかを確認
    unless self == other_user
      self.follows.find_or_create_by(follow_id: other_user.id)
    end
 end

  def unfollow(other_user)
    follow = self.follows.find_by(follow_id: other_user.id)
    #followしている場合フォローを解除する
    follow.destroy if follow
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
