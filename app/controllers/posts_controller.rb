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

    # deleted code
    # @post = Post.new

    #  # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources
    #  # We have the route, so now we need to update our posts_controller#new
    #  # action to handle the :author_id parameter.
    #  # new code
    #  #@post = Post.new(author_id: params[:author_id])

    # While we're at it, we should fix up our new action to ensure that we're
    # creating a new post for a valid author. Let's make it look like this:
    # new code start
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to authors_path, alert: "Author not found."
    else
      @post = Post.new(author_id: params[:author_id])
    end
    # new code end\
    
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

    # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources
    # deleted code
    #@post = Post.find(params[:id])

    # new code start
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
    # new code end

  end

  private

  # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources
  # Remember Strong Parameters? We need to update our posts_controller to
  # accept :author_id as a parameter for a post. So let's get in there and
  # modify our post_params method.
  def post_params

    # deleted code
    # params.require(:post).permit(:title, :description)

    # new code
    params.require(:post).permit(:title, :description, :author_id)
    # Why didn't we have to make a nested resource route for :create in
    # addition to :new?  The form_for(@post) helper in posts/_form.html.erb
    # will automatically route to POST posts_controller#create for a new Post.
    # By carrying the author_id as we did and allowing it through strong
    # parameters, the existing create route and action can be used without
    # needing to do anything else.
  end
end
