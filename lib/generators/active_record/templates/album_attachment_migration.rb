class RubyGalleryCreateAlbumAttachments < ActiveRecord::Migration
  def change
    create_table :album_attachments do |a|
      a.string :parent_type
      a.integer :parent_id
      a.timestamps
    end
  end
end