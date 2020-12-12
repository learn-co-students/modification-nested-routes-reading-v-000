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
    #make sure the post is assigned to a valid author
    # Author.exists?(params[:author_id]) ? @post = Post.new(author_id: params[:author_id]) : redirect_to(authors_path, alert: "Author not found.")
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    if params[:author_id]
        if author = Author.find_by(id: params[:author_id])
          #author exists
          @post = author.posts.find_by(id: params[:id])
          @post ? @post : redirect_to(author_posts_path(author), alert: "Post not found.")
        else
          redirect_to authors_path, alert: "Author not found."
        end
    else
      @post = Post.find(params[:id])
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
