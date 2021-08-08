# README

The purpose of this repo is to demonstrate an issue with Rails and using `accepts_nested_attributes_for`. Reproduction steps by running the following:

1. Run: `ruby lib/rails-bug-report.rb` - This file is an executable test case from [Rails](https://edgeguides.rubyonrails.org/contributing_to_ruby_on_rails.html#create-an-executable-test-case). The test will pass

Now proceed to run the following:

2. `bundle install`
3. `rake db:migrate`
4. `rails c`
5. Paste the following:

```ruby
author_params = {
  first_name: 'Joe',
  last_name: 'Bloggs',
  bio: 'Foo',
  posts_attributes: [{title: 'Cool', body: 'Beans'}]
}
Author.create(author_params)
```
You'll find that upon running: `Author.create(author_params)` it won't persist the record. The expectation should be that the Author & Post records are persisted (per rails-bug-report.rb expectation). Making things more interesting you'll find that if you run `rails test` the test fail. Whereas if you run: `ruby lib/rails-bug-report.rb` which contains the _exact_ same tests the pass.
