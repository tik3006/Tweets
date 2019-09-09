class Post < ApplicationRecord
  #1ユーザーに対し、対のPostがあることを表す
  belongs_to :user
  
  #投稿の最大長を144文字とする
  validates :content, presence: true, length: { maximum: 144}
end
