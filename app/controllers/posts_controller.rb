class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

  def new
  # We check :author_id if exists, if Not go to last else clause.
  if params[:author_id]    
    # Check db for valid Author
    if !Author.exists?(params[:author_id])
      # if Not valid, go to authors#index alert.
      redirect_to authors_path, alert: "Author not found."
    else
      # if valid, Post.new with author_id associated
      @post = Post.new(author_id: params[:author_id])
    end
  # if no :author_id, not nested route, build new post as usual.
  else
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    # look for existence of :author_id which comes from nested route
    if params[:author_id]
      # Look for a valid Author
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        # if no valid Author is found, direct to authors#index and alert.
        redirect_to authors_path, alert: "Author not found."
      else
        # if Valid Author found, look for valid Post by that Author.
        @post = author.posts.find_by(id: params[:id])
        # if no valid Author.post exists, redirect to posts#index and alert
        redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
      end
    else
      # if No :author_id it is not a nested route, procced as normal
      @post = Post.find(params[:id])
    end    
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
