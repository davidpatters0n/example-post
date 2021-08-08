class Author < ApplicationRecord
  has_many :posts, foreign_key: 'special_author_id'
  accepts_nested_attributes_for :posts
end
