module PostsHelper
  def author_id_field(post)
    if post.author.nil?
      select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
    else
      hidden_field_tag "post[author_id]", post.author_id
    end
  end

  # above code replaces the following code previously in _form:
  # <% if @post.author.nil? %>
    # <%= f.select :author_id, options_from_collection_for_select(Author.all, :id, :name) %><br>
  # <% end %>
  
  # <%= f.hidden_field :author_id %>
end
