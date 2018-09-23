class AuthorsController < ApplicationController

  def show
    @author = Author.find_by(id: params[:id])
  end

  def index
    @authors = Author.all
  end

end
