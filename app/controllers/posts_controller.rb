=begin

Notes for form. Post_controller class underneath.

#_form.html.erb

<%= form_for(@post) do |f| %>
  <label>Post title:</label><br>
  <% if @post.author.nil? %>
    <%= f.select :author_id, options_from_collection_for_select(Author.all, :id, :name) %><br>
  <% end %>

  That gives us a select control if we don't have an author, but we have a problem. We can only have one :author_id field. We could put that hidden_field in an else, which would work, but then we would have a whole bunch of logic cluttering up our view. So let's dump it in our posts_helper and clean up that form.
  
  <%= f.hidden_field :author_id %>

  We set it up in the new action, but it never made it to the view so that it could get submitted back to the server. Let's fix that.

  <%= f.text_field :title %><br>

  <label>Post Description</label><br>
  <%= f.text_area :description %><br>

  <%= f.submit %>
<% end %>

We can only have one :author_id field. We could put that hidden_field in an else, which would work, but then we would have a whole bunch of logic cluttering up our view. So let's dump it in our posts_helper and clean up that form.

 <%= form_for(@post) do |f| %>
  <%= author_id_field(@post) %>
  <br>
  <label>Post title:</label><br>
  <%= f.text_field :title %><br>

  <label>Post Description</label><br>
  <%= f.text_area :description %><br>

  <%= f.submit %>
<% end %>

=end

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

=begin

#posts/show.html.erb

<h1><%= @post.title %></h1>
<p>by <%= link_to @post.author.name, author_path(@post.author) if @post.author %> (<%= link_to "Edit Post", edit_post_path(@post) %>)</p>
<p><%= @post.description %> </p>

changed to

<p>by <%= link_to @post.author.name, author_path(@post.author) if @post.author %> (<%= link_to "Edit Post", edit_author_post_path(@post.author, @post) if @post.author %>)</p>

We don't have to change any views because new and edit both use the same _form partial that already has the author_id.
Now we need to update our post show view to give us the new nested link to edit the post for the author.

=end

  #We have the route, so now we need to update our posts_controller#new action to handle the :author_id parameter.

  def new
    #@post = Post.new 

    #@post = Post.new(author_id: params[:author_id])
   
    #  We want to make sure that, if we capture an author_id through a nested route, we keep track of it and assign the post to that author. 
    
    #  We'll actually be carrying this id with us for the next few steps, babysitting it through the server request/response cycle.
    #so this was added instead.

    if params[:author_id] && !Author.exists?(params[:author_id]) 
      redirect_to authors_path, alert: "Author not found."
    else
      @post = Post.new(author_id: params[:author_id])
    end

    #Here we check for params[:author_id] and then for Author.exists? to see if the author is real.
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

    #Here we're looking for the existence of params[:author_id], 
    #which we know would come from our nested route. If it's there,
    # we want to make sure that we find a valid author. 
    #If we can't, we redirect them to the authors_path with a flash[:alert].
  end

  private

  def post_params
    #params.require(:post).permit(:title, :description)
    
    params.require(:post).permit(:title, :description, :author_id)
    
    ##Now we know the author_id will be allowed for mass-assignment in the create action.
  end
end
