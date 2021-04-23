module PostsHelper
  
    def author_id_field(post)
        # using form_tag helpers because we are outside the form_for model at this point
        # we need to explicitly construct the name values so our params hash is organized as expected
        if post.author.nil?
            # added to allow selection of an author value if one is not sent via the calling action
            select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
        else
            # added to carry author id from the new action to the create action
            hidden_field_tag "post[author_id]", post.author_id
        end
    end
end
