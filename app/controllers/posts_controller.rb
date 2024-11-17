# Controller for managing CRUD operations on posts, allowing users to create, view, edit, update, and delete their posts.
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  # Redirects to the root path as posts index is not directly accessible.
  def index
    redirect_to root_path
  end

  # GET /posts/1 or /posts/1.json
  # Displays a specific post.
  def show
  end

  # GET /posts/new
  # Initializes a new Post object for form display.
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  # Retrieves the post for editing if it belongs to the current user.
  def edit
  end

  # POST /posts or /posts.json
  # Creates a new post associated with the current user.
  # On success, redirects to the post’s show page or returns JSON response;
  # on failure, redirects to the root with an alert or returns error JSON.
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to root_path, alert: @post.errors.full_messages.to_sentence }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  # Updates an existing post's attributes. On success, redirects to the post or returns JSON response.
  # On failure, re-renders edit form or returns error JSON.
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  # Deletes the post if it belongs to the current user.
  # On success, redirects to posts list or returns a no-content JSON response.
  def destroy
    return if current_user != @post.user
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Sets @post instance variable for actions that require a specific post.
    def set_post
      @post = Post.find(params[:id])
    end

    # Strong parameters for permitted post attributes.
    def post_params
      params.require(:post).permit(:caption, :longitude, :latitude, :user_id, :allow_comments, :show_likes_count, images: [])
    end
end
