class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.bigint :album_id, null: false, unique: true, index: true
      t.string :title, null: false
      t.string :subtitle
      t.string :thumbnail
      t.boolean :favorite, default: false, null: false
      
      t.timestamps
    end
  end
end