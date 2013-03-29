require 'rails/generators/active_record'
require 'generators/ruby_gallery/orm_helpers'
module ActiveRecord
  module Generators
    class RubyGalleryGenerator < ActiveRecord::Generators::Base
      include RubyGallery::Generators::OrmHelpers
      argument :attributes, :type => :array, :default => [], :banner => "filed:type field:type"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def copy_ruby_gallery_migration
        route "put '/#{table_name}/update_ruby_gallery_position', controller: :#{table_name}, action: :update_ruby_gallery_position"
        route "post '/#{table_name}/upload_album', controller: :#{table_name}, action: :upload_album"
        route "delete '/#{table_name}/:id/delete_photo', controller: :#{table_name}, action: :delete_photo"
        if migration_exists?("album_photos") && migration_add_columns_exists?("album_photos")
          # migration_template "migration.rb", "db/migrate/ruby_gallery_add_columns_to_album_photos" unless migration_add_columns_exists?("album_photos")
        else
          migration_template "album_photo_migration.rb", "db/migrate/ruby_gallery_create_album_photos"
          migration_template "migration.rb", "db/migrate/ruby_gallery_add_columns_to_album_photos"
        end
      end
      
      def inject_ruby_gallery_content_to_model
        content = %Q{  has_many :album_photos, as: :photoable}
        class_path = class_name.to_s.split("::")
        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"
        inject_into_class(model_path, class_path.last, content) if model_exists?
      end
      
      def inject_ruby_gallery_content_to_controller
        content = %Q{  upload_album_for :#{table_name}}

        class_path = class_name.to_s.split("::")
        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"
        inject_into_class(controller_path, class_path.last.tableize.camelize + "Controller", content) if controller_exists?
      end
    end
  end
end