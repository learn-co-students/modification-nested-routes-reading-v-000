Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    # add :new to create posts by author
    # this creates /authors/:id/posts/new
    # and new_author_post_path helper

    # to edit an author's posts, add :edit action in the nested route
    # there is no need to change any views because new and edit both use the same _form partial that already has the same author_id.
    resources :posts, only: [:show, :index, :new, :edit]
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
