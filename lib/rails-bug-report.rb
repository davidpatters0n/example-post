# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  ruby '2.6.3'

  gem 'rails', '~> 6.1.4'
  gem 'sqlite3', '~> 1.4'
  gem 'puma', '~> 5.0'
end

require "active_record"
require "minitest/autorun"
require "logger"

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)


class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :special_author, index: true, foreign_key: {to_table: :authors}
      t.string(:title)
      t.string(:body)
      t.timestamps
    end
  end
end

class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string(:first_name)
      t.string(:last_name)
      t.string(:bio)
      t.timestamps
    end
  end
end

CreatePosts.new.change
CreateAuthors.new.change

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Author < ApplicationRecord
  has_many :posts, foreign_key: 'special_author_id'
  accepts_nested_attributes_for :posts
end

class Post < ApplicationRecord
  belongs_to :author
end

class BugTest < Minitest::Test
  def test_association_stuff
    author_params = {first_name: 'Joe', last_name: 'Bloggs', bio: 'Foo', posts_attributes: [{title: 'Cool', body: 'Beans'}]}
    author = Author.create(author_params)

    assert_equal 1, author.posts.count
  end
end
