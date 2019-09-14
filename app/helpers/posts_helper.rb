module PostsHelper
    #We can only have one :author_id field. We could put that hidden_field in an else, which would work, but then we would have a whole bunch of logic cluttering up our view. So let's dump it in our posts_helper and clean up that form.
    def author_id_field(post)
      if post.author.nil?
        select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
      else
        hidden_field_tag "post[author_id]", post.author_id
      end
    end
  end