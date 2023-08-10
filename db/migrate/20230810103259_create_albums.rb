class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.bigint :album_id, null: false, unique: true, index: true
      t.boolean :favorite, default: false, null: false
      
      t.timestamps
    end
  end
end