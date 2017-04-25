class User < ApplicationRecord
  # User インスタンス（レコード）を保存するその前に、実行。すべて小文字に
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    # メールアドレス判定
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    # case_sensitive: false  大文字と小文字を区別しない
                    uniqueness: { case_sensitive: false }
  has_secure_password

#  has_many :microposts
  # https://railsguides.jp/association_basics.html#has-many%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91
end
