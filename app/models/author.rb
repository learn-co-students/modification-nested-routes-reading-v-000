class Author < ActiveRecord::Base
  has_many :posts

  def find_post(post_id)
    posts.find(post_id)
  end
end
