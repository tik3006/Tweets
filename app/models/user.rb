class User < ApplicationRecord
  #メールアドレスを小文字に変換する
  before_save { self.email.downcase! }
  #Usernameは最大長は50とする
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
 
 validates :password, presence: true, length: { maximum: 10 }
  
  
  has_secure_password
  
  #アソシエーション
  has_many :posts, dependent: :destroy
  has_many :follows
  has_many :followings, through: :follows, source: :follow
  has_many :reverses, class_name: 'Follow', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses, source: :user

 #favorites
  has_many :favorites, dependent: :destroy
  has_many :favorite_post, through: :favorites, source: :post


 def following(other_user)
    #フォローしようとしているユーザが自分ではないかを確認
    unless self == other_user
      self.follows.find_or_create_by(follow_id: other_user.id)
    end
 end

 def unfollow(other_user)
    follow = self.follows.find_by(follow_id: other_user.id)
    follow.destroy if follow
 end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #タイムラインの取得
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
   #お気に入りの追加
  def like(post)
    favorites.find_or_create_by(post_id: post.id)
  end
  
  #お気に入りの削除
  def unlike(post)
   favorite = favorites.find_by(post_id: post.id)
   favorite.destroy if favorite
  end 
  
  #お気に入りの判定
  def liked?(post)
    favorite_post.include?(post)
  end
end