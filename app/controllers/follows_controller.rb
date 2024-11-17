# Controller for managing follow actions such as following, unfollowing, accepting, and declining follow requests.
class FollowsController < ApplicationController
  before_action :set_user, only: [ :follow, :unfollow, :cancel_request ]
  before_action :set_follow_request, only: [ :accept_follow, :decline_follow ]

  # Sends a follow request from the current user to the specified user.
  # Redirects back to the previous page or to the root path if no referrer is available.
  def follow
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  # Cancels a follow request from the current user to the specified user.
  # Redirects back to the previous page or to the root path if no referrer is available.
  def cancel_request
    current_user.cancel_request(@user)
    redirect_back(fallback_location: root_path)
  end

  # Unfollows the specified user for the current user.
  # Redirects back to the previous page or to the root path if no referrer is available.
  def unfollow
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end

  # Accepts a pending follow request, establishing a follow relationship.
  # Redirects back to the previous page or to the root path if no referrer is available.
  def accept_follow
    @follow_request.accept
    redirect_back(fallback_location: root_path)
  end

  # Declines a pending follow request by destroying it.
  # Redirects back to the previous page or to the root path if no referrer is available.
  def decline_follow
    @follow_request.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  # Finds the user to be followed/unfollowed or whose follow request is to be managed.
  def set_user
    @user = User.find(params[:user_id])
  end

  # Finds the follow request associated with the given follow_id.
  def set_follow_request
    @follow_request = Follow.find(params[:follow_id])
  end
end
