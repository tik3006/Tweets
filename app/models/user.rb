class User < ApplicationRecord
  #メールアドレスを小文字に変換する
  before_save { self.email.downcase! }
  #Usernameは最大長は50とする
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
end
