class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body, limit: 500
      t.string :type
      t.references :user, index: true, foreign_key: true
      t.string :slug

      t.timestamps null: false
    end
    add_index :posts, :slug, unique: true
  end
end
