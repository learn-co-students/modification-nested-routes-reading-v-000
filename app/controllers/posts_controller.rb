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
    #@post = Post.new
    #@post = Post.new(author_id: params[:author_id])
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
    #@post = Post.find(params[:id])
    if params[:author_id]
      author = Author.find_by(id: params[:author_id]) #find_by is used to iterate through the collection of posts that are by that author!! not just searching for that author id. Need to be that author id and be associated with those posts. 
      if author.nil? #if no author
        redirect_to authors_path, alert: "Author not found." #flash message 
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
