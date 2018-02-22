class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
     binding.pry
    if params[:author_id]
      @author = Author.posts.find_by_id(params[:author_id])
    else
      @post = Post.find_by(:id => params[:id])
    end
  end

  def new

    if params[:author_id] && !Author.exists? (params:[:author_id])
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
      @author = Author.find_by(id: params[:author_id])
       if @author.nil?
        redirect_to authors_path, flash[:alert] = "Author not found."
        else
          @post = @author.posts.find_by(id: params[:id])
           redirect_to author_posts_path(@author), flash[:alert] = "Post not found." if @post.nil?
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
