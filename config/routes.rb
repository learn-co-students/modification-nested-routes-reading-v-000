Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:new, :show, :index, :edit]
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
