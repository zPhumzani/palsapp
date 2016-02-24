class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
    add_index :photos, :slug, unique: true
  end
end
