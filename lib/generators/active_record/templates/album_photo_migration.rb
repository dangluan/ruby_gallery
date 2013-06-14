class RubyGalleryCreateAlbumPhotos < ActiveRecord::Migration
  def self.up
    create_table :album_photos do |b|
      b.belongs_to :photoable, polymorphic: true
      b.integer :position, default: 0
      b.timestamps
    end
    add_index :album_photos, [:photoable_id, :photoable_type]
  end
  
  def self.down
    drop_table :album_photos
  end

end