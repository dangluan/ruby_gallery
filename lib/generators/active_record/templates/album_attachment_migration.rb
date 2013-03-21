class CreateAlbumAttachment < ActiveRecord::Migration
  def up
    create_table :album_attachments do |a|
      a.string :parent_type
      a.integer :parent_id
      a.timestamps
    end
  end
  
  def down
    drop_table :album_attachments
  end
end