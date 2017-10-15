Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:new, :show, :index, :edit]
  end
 # => author_posts GET   /authors/:author_id/posts(.:format)     posts#index
 # => new_author_post GET   /authors/:author_id/posts/new(.:format) posts#new
 # => author_post GET   /authors/:author_id/posts/:id(.:format) posts#show
# => edit_author_post GET   /authors/:author_id/posts/:id/edit(.:format) posts#edit
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
