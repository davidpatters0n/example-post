class BugTest < Minitest::Test
  def test_association_stuff
    author_params = {first_name: 'Joe', last_name: 'Bloggs', bio: 'Foo', posts_attributes: [{title: 'Cool', body: 'Beans'}]}
    author = Author.create(author_params)

    assert_equal 1, author.posts.count
  end
end
