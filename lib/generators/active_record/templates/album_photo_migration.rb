class RubyGalleryCreateAlbumPhotos < ActiveRecord::Migration
  def change
    create_table :album_photos do |b|
      b.belongs_to :photoable, polymorphic: true
      b.timestamps
    end
    
    add_index :album_photos, [:photoable_id, :photoable_type]
  end


end