Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #resources :authors, only: [:show, :index] do
  #  resources :posts, only: [:show, :index, :new]
  #end

  #changed to

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end

  #We already used nested resources to view posts by author, 
  #so now let's look at nested resources to create posts by author. 
  #As usual, we want to start with the route. We want to add :new to our nested :posts resource:
end

