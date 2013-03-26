require 'rails/generators/active_record'
require 'generators/ruby_gallery/orm_helpers'
module ActiveRecord
  module Generators
    class RubyGalleryGenerator < ActiveRecord::Generators::Base
      include RubyGallery::Generators::OrmHelpers
      argument :attributes, :type => :array, :default => [], :banner => "filed:type field:type"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def copy_ruby_gallery_migration
          migration_template "migration.rb", "db/migrate/ruby_gallery_add_columns_to_#{table_name}"
          route "post '/#{table_name}/upload_album', controller: :#{table_name}, action: :upload_album"
          route "delete '/#{table_name}/:id/delete_photo', controller: :#{table_name}, action: :delete_photo"
          migration_template "album_photo_migration.rb", "db/migrate/ruby_gallery_create_album_photos"
        #migration_template "album_attachment_migration.rb", "db/migrate/ruby_gallery_create_album_attachments"
      end
      
      # def add_routes
      #         route "post '/#{table_name}/upload_album', controller: :#{table_name}, action: :upload_album"
      #         route "delete '/#{table_name}/:id/delete_photo', controller: :#{table_name}, action: :delete_photo"
      #       end
    
    end
  end
end