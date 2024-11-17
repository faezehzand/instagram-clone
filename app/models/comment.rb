# Comment model that represents comments made by users on posts.
#
# This model is associated with:
# - A user who created the comment (`belongs_to :user`)
# - A post on which the comment is made (`belongs_to :post`)
#
# Validations:
# - The `body` attribute must be present for a comment to be valid.
#
class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :body, presence: true
end
