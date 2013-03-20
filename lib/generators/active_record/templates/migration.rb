class RubyGalleryAddColumnTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>
  end
end