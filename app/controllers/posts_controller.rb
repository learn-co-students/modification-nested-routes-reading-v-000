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
      @post = Author.find(params[:author_id]).find_post(params[:id]) # I refactored this.
      # Note: This breaks if I mismatch the author and the post; I'll need to do something similar to the #edit action.
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    # My attempt:
    # if params[:author_id]
      # author = Author.find_by_id(params[:author_id])
      # 
      # if author
        # @post = Post.new(author_id: params[:author_id])
        # This works even if `localhost:3000/posts/new` is called, since author_id would be nil.
        # @post = Post.new is NOT needed.
      # else
        # redirect_to authors_path, alert: "Author not found."
      # end
    # else # This statement is not needed; see above.
      # @post = Post.new
    # end

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
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    if params[:author_id]
      author = Author.find_by_id(params[:author_id])

      if author.nil?
        redirect_to authors_path, alert: "Author not found."
      else
        @post = author.posts.find_by_id(params[:id])
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
