# Like model that represents a 'like' relationship between a user and a post.
#
# This model is used to track which users have liked which posts, ensuring that a user can
# only like a particular post once. It enforces uniqueness on the combination of user and post.
#
# Associations:
# - `user`: the user who has liked the post.
# - `post`: the post that has been liked by the user.
#
# Validations:
# - Ensures that a user cannot like the same post multiple times by validating the uniqueness
#   of the `user_id` scoped to the `post_id`.
#
class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :user_id, uniqueness: { scope: :post_id, message: "can only like a post once" }
end
