class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

=begin
  #authors/show.html.erb

  added <%= link_to "New Post", new_author_post_path(@author) %> 

=end
  def index
    @authors = Author.all
  end

  
end
