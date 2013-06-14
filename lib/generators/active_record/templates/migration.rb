class RubyGalleryAddColumnsToAlbumPhotos < ActiveRecord::Migration
  def self.up
    has_attached_file :album_photos, :photo
  end
  
  def self.down
    has_attached_file :album_photos , :photo
  end
end