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

  # update the #new action to handle the :author_id parameter
  # if author_id is captured through a nested route, we keep track
  # of it and assign the post to that author

  def new
    # ensure that a new post is created for a valid author
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
    # check if params[:author_id] exists, which would come from the
    # nested route. if it is there, make sure that there is a valid
    # author. if there is not valid author, redirect to the authors_path with a flash[:alert].
    # if the author is found, next find the post by params[:id]
    # instead of directly looking for Post.find(), filter the query
    # through author.posts collection to make sure it is in that
    # author's posts. it may be a valid post id, but it might not
    # belong to that author, which makes this request invalid.
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        redirect_to authors_path, alter: "Author not found."
      else
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
      end
    else
      @post = Post.find(params[:id])
    end
  end

  private
  #accept :author_id as a parameter for a post
  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
