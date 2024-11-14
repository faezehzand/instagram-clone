class Post < ApplicationRecord
  # A Post represents a piece of content created by a user, which can include multiple images, likes, and comments.
  #
  # Associations:
  # - `user`: The user who created the post.
  # - `images`: A collection of images attached to the post.
  # - `likes`: A collection of likes associated with the post.
  # - `likers`: Users who liked the post, accessed through the likes association.
  # - `comments`: A collection of comments associated with the post.
  #
  # Validations:
  # - Ensures at least one image is attached to the post.
  # - Custom validation to ensure all attached files are images.
  #
  # Example:
  #   post = Post.new(user: user_instance)
  #   post.images.attach(image_instance)
  #   if post.valid?
  #     post.save # The post will be saved only if all validations pass.

  belongs_to :user
  has_many_attached :images

  # Ensure the images are present and of the correct content type
  validates :images, presence: true
  validate :acceptable_image

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user, dependent: :destroy

  has_many :comments, dependent: :destroy

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
