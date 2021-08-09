class Author < ApplicationRecord
  has_many :posts, foreign_key: :special_author_id, inverse_of: :author
  accepts_nested_attributes_for :posts
end
