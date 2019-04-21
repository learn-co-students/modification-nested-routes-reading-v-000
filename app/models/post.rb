class Post < ActiveRecord::Base

  validate :is_title_case 
  before_validation :make_title_case 
  belongs_to :author

  #put new code here
  def self.from_today
    where("created_at >=?", Time.zone.today.beginning_of_day)
  end

  def self.old_news
    where("created_at <?", Time.zone.today.beginning_of_day)
  end

  def self.by_author(author_id)
    where(author: author_id)
  end
  
  def author_id_field(post)
    if post.author.nil?
      select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
    else
      hidden_field_tag "post[author_id]", post.author_id
    end
  end

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
