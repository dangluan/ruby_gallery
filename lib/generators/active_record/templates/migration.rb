class RubyGalleryAddColumnsToAlbumPhotos < ActiveRecord::Migration
  def self.up
    add_attachment :album_photos, :photo
  end
  
  def self.down
    remove_attachment :album_photos , :photo
  end
end