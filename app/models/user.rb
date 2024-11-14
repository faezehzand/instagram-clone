class User < ApplicationRecord
  # The User model represents a user in the application, handling authentication and relationships with posts, likes, comments, and follows.
  #
  # Devise modules included:
  # - :database_authenticatable: Handles authentication with a username and password.
  # - :registerable: Allows users to register and manage their account.
  # - :recoverable: Allows users to recover their password.
  # - :rememberable: Manages generating and clearing a token for remembering the user from a saved cookie.
  # - :validatable: Provides validations for email and password.
  #
  # Associations:
  # - has_many :posts: A user can create multiple posts.
  # - has_one_attached :profile_photo: A user can have one profile photo attached.
  # - has_many :likes: A user can like multiple posts.
  # - has_many :comments: A user can comment on multiple posts.
  # - Follow relationships:
  #   - has_many :follow_requests: Requests sent to the user that are not yet accepted.
  #   - has_many :accepted_received_requests: Accepted follow requests directed at the user.
  #   - has_many :accepted_sent_requests: Accepted follow requests sent by the user.
  #   - has_many :waiting_sent_requests: Follow requests sent by the user that are still pending.
  #   - has_many :followers: Users who are following this user.
  #   - has_many :followings: Users that this user is following.
  #   - has_many :waiting_followings: Users that this user has sent follow requests to but are pending.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_one_attached :profile_photo

  has_many :likes
  has_many :comments

  has_many :follow_requests, -> { where(accepted: false) }, class_name: "Follow", foreign_key: "followed_id"

  has_many :accepted_recieved_requests, -> { where(accepted: true) }, class_name: "Follow", foreign_key: "followed_id"

  has_many :accepted_sent_requests, -> { where(accepted: true) }, class_name: "Follow", foreign_key: "follower_id"

  has_many :waiting_sent_requests, -> { where(accepted: false) }, class_name: "Follow", foreign_key: "follower_id"

  has_many :followers, through: :accepted_recieved_requests, source: :follower
  has_many :followings, through: :accepted_sent_requests, source: :followed
  has_many :waiting_followings, through: :waiting_sent_requests, source: :followed

  def follow(user)
    Follow.create(follower: self, followed: user)
  end

  def unfollow(user)
    self.accepted_sent_requests.find_by(followed: user)&.destroy
  end

  def cancel_request(user)
    self.waiting_sent_requests.find_by(followed: user)&.destroy
  end
end
