module PostsHelper
  def author_id_field(post)
    if @post.author_id.nil? # I changed this to avoid an unnecessary call to the database.
      select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
    else
      hidden_field_tag "post[author_id]", post.author_id
    end
  end
end
