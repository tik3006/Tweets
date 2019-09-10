class Post < ApplicationRecord
  #1ユーザーに対し、対のPostがあることを表す
  belongs_to :user
  
  #投稿の最大長を144文字とする
  validates :content, presence: true, length: { maximum: 144}
  
   #お気に入り機能中間テーブル
  has_many :favorites
  has_many :liked_users, through: :favorites, source: :user

end
