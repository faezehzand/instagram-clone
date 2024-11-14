# Controller to manage user-specific actions, such as showing a user's profile.
class UsersController < ApplicationController
  before_action :set_user

  # GET /users/:id
  # Displays the user profile page for the specified user.
  def show
  end

  private

  # Sets the @user instance variable based on the user ID parameter.
  # This is used in actions where user information is required.
  def set_user
    @user = User.find(params[:id])
  end
end
