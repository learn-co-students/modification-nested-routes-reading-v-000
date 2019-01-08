Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    
  # this gives us access to /authors/:id/posts/new, and a new_author_post_path helper.
    resources :posts, only: [:show, :index,:new]
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
