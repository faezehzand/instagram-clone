class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  # Ensure the images are present and of the correct content type
  validates :images, presence: true
  validate :acceptable_image

  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_many :comments
  private

  # Custom validation for image file type
  def acceptable_image
    images.each do |image|
      unless image.content_type.start_with?("image/")
        errors.add(:images, "must be an image")
      end
    end
  end
end
