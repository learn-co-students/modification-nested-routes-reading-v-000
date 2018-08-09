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
#Here we check for params[:author_id] and then for Author.exists? #to see if the author is real.

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
# Here we're looking for the existence of params[:author_id], which # we know would come from our nested route. If it's there, we want #  to #make sure that we find a valid author. If we can't, we #redirect #them to the authors_path with a flash[:alert].#
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
    if author.nil?
      redirect_to authors_path, alert: "Author not found."
    else
      @post = author.posts.find_by(id: params[:id])
      redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
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
