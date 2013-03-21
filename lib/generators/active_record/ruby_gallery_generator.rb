require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class RubyGalleryGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "filed:type field:type"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def copy_ruby_gallery_migration
        migration_template "album_photo_migration.rb", "db/migrate/create_ablum_photo_table"
        migration_template "migration.rb", "db/migrate/ruby_gallery_add_columns_to_#{table_name}"
        migration_template "album_attachment_migration.rb", "db/migrate/create_album_attachment_table"
      end
  end
end