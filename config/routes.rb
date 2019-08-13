Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:index, :show] do
    resources :posts, only: [:new, :edit, :index, :show]
  end
  resources :posts
end
