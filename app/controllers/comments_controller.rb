# Controller for handling comment-related actions such as creation and deletion of comments on posts.
class CommentsController < ApplicationController
  before_action :set_post, only: [ :create ]

  # Creates a new comment on a specific post associated with the current user.
  # Renders the updated comments section via Turbo Streams, or redirects to the post page.
  def create
    @comment = @post.comments.create(user: current_user, body: params[:comment_body])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "post#{@post.id}comments",
          partial: "posts/post_comments",
          locals: { post: @post }
        )
      end
      format.html { redirect_to post_path(@post) }
    end
  end

  # Deletes a comment if it belongs to the current user.
  # Renders a Turbo Stream to remove the comment from the page, or redirects to the post page with a success notice.
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(
            "post#{@comment.post_id}ModalComment#{@comment.id}"
          )
        end
        format.html { redirect_to post_path(@comment.post), notice: "Comment was successfully deleted." }
      end
    end
  end

  private

  # Sets the post based on post_id provided in the params.
  # This is used only for creating a new comment on a post.
  def set_post
    @post = Post.find(params[:post_id])
  end
end
