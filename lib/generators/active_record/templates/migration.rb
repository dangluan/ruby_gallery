class RubyGalleryAddColumnTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    add_attachment :<%= table_name %>, :photo
  end
  
  def self.down
    remove_attachment :<%= table_name %>, :photo
  end
end