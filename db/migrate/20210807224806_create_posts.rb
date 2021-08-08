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
