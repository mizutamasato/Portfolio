class Review < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
