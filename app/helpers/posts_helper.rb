module PostsHelper
  def author_id_field(post,f,authors)
    if post.author.nil?
      f.collection_select :author_id, authors, :id, :name
    else
      f.hidden_field :author_id
    end
  end
end
