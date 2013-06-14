class RubyGalleryAddColumnsToAlbumPhotos < ActiveRecord::Migration
  def self.up :album_photos do |t|
    t.has_attached_file, :photo
  end
  
  def self.down
    drop_attached_file :album_photos , :photo
  end
end