# Controller for managing likes on posts, allowing users to toggle (like/unlike) a post.
class LikesController < ApplicationController
  before_action :set_post

  # POST /posts/:post_id/toggle_like
  # Toggles the like status on a post for the current user.
  # If a like exists, it is destroyed (unliked); if not, a new like is created.
  # Responds with Turbo Stream to update the UI dynamically, or with a redirect for HTML requests.
  def toggle_like
    # Find the like for the current user on this post, if it exists
    @like = @post.likes.find_by(user: current_user)

    if @like
      # Destroy the existing like (unlike)
      @like.destroy
    else
      # Create a new like
      @post.likes.create(user: current_user)
    end

    respond_to do |format|
      format.turbo_stream do
        # Renders a Turbo Stream update for the like/unlike action,
        # replacing the post actions section to reflect the current like status.
        render turbo_stream: turbo_stream.replace(
          "post#{@post.id}actions",
          partial: "posts/post_actions",
          locals: { post: @post }
        )
      end
      format.html do
        # Fallback redirect for non-Turbo Stream requests
        redirect_to @post
      end
    end
  end

  private

  # Sets the @post instance variable for actions in this controller by finding the post from params.
  def set_post
    @post = Post.find(params[:post_id])
  end
end
