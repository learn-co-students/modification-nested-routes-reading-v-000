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
    @post = Post.new(author_id: params[:author_id])
    # we want to make sure that if we capture author_id through a nested route, we keep track of it and assign the post to the author
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
    @post = Post.find(params[:id])
  end

  private

  def post_params
    # added :author_id to strong params so that it can be used for mass-assignment in the create action
    params.require(:post).permit(:title, :description, :author_id)
  end
end
