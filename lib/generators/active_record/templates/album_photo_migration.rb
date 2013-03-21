class CreateAlbumPhoto < ActiveRecord::Migration
  def up
    create_table :album_photos do |a|
      a.integer :album_attachment_id
      a.timestamps
    end
  end
  
  def down
    drop_table :album_photos
  end
end