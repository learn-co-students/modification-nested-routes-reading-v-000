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
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to authors_path, alert: "Author not found."
    else 
      @post = Post.new(author_id: params[:author_id])
    end
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
    if params[:author_id]
      begin 
        author = Author.find(params[:author_id])
      rescue ActiveRecord::RecordNotFound
        redirect_to authors_path, alert: "Author not found."
      end
      begin 
        @post = author.posts.find(params[:id]) if author
      rescue ActiveRecord::RecordNotFound
        redirect_to author_posts_path(author), alert: "Post not found."
      end
    else
      begin 
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to posts_path, alert: "Post not found"
      end
    end
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
