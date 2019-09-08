class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      #カラム名
      t.string :name  #ユーザー名
      t.string :email #メールアドレス
      t.string :password_digest #暗号化されたパスワード

      t.timestamps
    end
  end
end
