class Follow < ApplicationRecord
  # Callback to check privacy settings before creating a follow record
  before_create :check_privacy

  # Associations
  belongs_to :follower, class_name: "User", foreign_key: "follower_id"
  belongs_to :followed, class_name: "User", foreign_key: "followed_id"

  # Marks the follow request as accepted
  def accept
    self.update(accepted: true)
  end

  private

  # Checks if the followed user has a private profile and sets the acceptance status accordingly
  def check_privacy
    self.accepted = true unless self.followed.private
  end
end
