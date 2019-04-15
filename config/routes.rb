Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end

  resources :authors, only: [:index, :show, :new, :create, :edit, :update]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
