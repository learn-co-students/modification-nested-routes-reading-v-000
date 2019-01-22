Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]  #this gives us access to /authors/:id/posts/new and the helper new_author_post_path. #you only need new and edit here (create and update are automatically added via new/edit)  
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
