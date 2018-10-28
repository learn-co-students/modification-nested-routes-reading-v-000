Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end
#   Prefix Verb  URI Pattern                             Controller#Action
# author_posts GET   /authors/:author_id/posts(.:format)     posts#index
# new_author_post GET   /authors/:author_id/posts/new(.:format) posts#new
# edit_author_post GET   /authors/:author_id/posts/:id/edit(.:format) posts#edit

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
