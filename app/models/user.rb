class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.introduction
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
