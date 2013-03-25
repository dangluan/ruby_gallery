class RubyGalleryCreateAlbumPhotos < ActiveRecord::Migration
  def self.up
    drop_table :album_photos
  end
  def change
    create_table :album_photos do |b|
      b.integer :album_attachment_id
      b.integer :<%= table_name %>_id
      b.timestamps
    end
  end


end