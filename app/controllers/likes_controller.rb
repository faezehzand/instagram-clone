class LikesController < ApplicationController
    before_action :set_post

    def toggle_like
      # Find the like by the current user for the post
      @like = @post.likes.find_by(user: current_user)

      if @like
        # Destroy the like (unlike)
        @like.destroy
      else
        # Create a new like for the current user
        @post.likes.create(user: current_user)
      end

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "post#{@post.id}actions",
            partial: "posts/post_actions",
            locals: { post: @post }
          )
        end
        format.html do
          # Fallback for regular HTML requests
          redirect_to @post
        end
      end
    end


    private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
