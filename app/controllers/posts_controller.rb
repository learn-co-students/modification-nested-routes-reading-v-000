class PostsController < ApplicationController

  def index
    if params[:author_id]

      # Author not found
      if Author.find_by(id: params[:author_id]).nil?
        redirect_to authors_path, alert: "Author not found"

      # Display author's posts
      else
        @posts = Author.find_by(id: params[:author_id]).posts
      end

    # Display all posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]

      # Author not found
      if Author.find_by(id: params[:author_id]).nil?
        redirect_to authors_path, alert: "Author not found"

      # Author found
      else
        @author = Author.find_by(id: params[:author_id])

        # Author found but post not found
        if @author.songs.find_by(id: params[:id]).nil?
          redirect_to author_posts_path(@author), alert: "Post not found"

        # Display author's post
        else
          @post = @author.songs.find_by(id: params[:id])
        end
      end

    # Display post by id
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    # Author does not exist
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to posts_path, alert: "Author not found"

    # Create new post. Author id is either given or will be selected in form
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
      author = Author.find(params[:author_id])

      # Author does not exist
      if author.nil?
        redirect_to posts_path, alert: "Author not found"

      # Find post for edit. Redirect to author's posts path if post not found
      else
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: "Author's post not found" if @post.nil?
      end

    # Edit the post
    else
      @post = Post.find(params[:id])
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
