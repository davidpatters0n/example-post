class Post < ApplicationRecord
  belongs_to :author, inverse_of: :posts
end
