Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources
  # The first thing we want to do is to create a new post that is automatically
  # linked to an Author. We could set up a select box on the post page and
  # make the author choose. However, if we're already on the author's page,
  # we know who the author is, so why not do it without forcing the user to
  # choose?  We already used nested resources to view posts by author,
  # so now let's look at nested resources to create posts by author.
  # As usual, we want to start with the route. We want to add :new to our
  # nested :posts resource:

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new]
  end
  resources :posts

  # This gives us access to /authors/:id/posts/new, and a new_author_post_path helper.

end
