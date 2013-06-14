class RubyGalleryAddColumnsToAlbumPhotos < ActiveRecord::Migration
  def change_table :album_photos do |t|
    t.attachment, :photo
  end
  
  def self.down
    remove_attachment :album_photos , :photo
  end
end