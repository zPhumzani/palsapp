class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.date :date_of_birth
      t.string :location
      t.string :languages
      t.string :interest
      t.string :favorite_movies
      t.string :favorite_music
      t.text :bio
      t.text :favorite_qoutes     

      t.timestamps null: false
    end
  end
end
