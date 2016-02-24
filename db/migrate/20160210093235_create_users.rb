class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :gender, limit: 20
      t.string :slug

      t.timestamps null: false
    end
    add_index :users, :slug, unique: true
  end
end
