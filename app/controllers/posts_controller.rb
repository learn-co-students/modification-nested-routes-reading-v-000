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
    #  # we put this to handle the new from our routes in resources
    #  But what if params[:author_id] is nil in the example above? 
    #  If we just did Post.new without the (author_id: params[:author_id]) argument, 
    #  the author_id attribute of the new Post would be initialized as nil anyway. 
    #  So we don't have to do anything special to handle it. 
    #   It works for us if there is or isn't an author_id present.
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
      author = Author.find_by(id: params[:author_id])

        if author.nil?
          redirect_to authors_path, alert: "Author not found."
        else
          @post = author.posts.find_by(id: params[:id]) # targeting id of posts of specific author if we have it
          redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
        end

    else
      @post = Post.find(params[:id])
    end
  end
  # #  Remember how we didn't have to change 
  # the controller when we added the nested 
  # resource route for :edit? Well, this is 
  # the price we pay for taking shortcuts.
  #  What we should do is check to make sure that 
  #   1) the author_id is valid and 2) the post 
  #   matches the author. So let's fix that now.


 

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
