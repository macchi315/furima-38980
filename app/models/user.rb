class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :password, length: { minimum: 6 }
    validates :last_name, format: { with: /[一-龥ぁ-ん]/ }
    validates :first_name, format: { with: /[一-龥ぁ-ん]/ }
    validates :last_name_kana, format: { with: /[ァ-ヶ]/ }
    validates :first_name_kana, format: { with: /[ァ-ヶ]/ }
    validates :birth
    with_options uniqueness: true do
      validates :email
    end
  end

  has_many :items
  has_many :purchases
  
end

