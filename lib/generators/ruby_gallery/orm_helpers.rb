module RubyGallery
  module Generators
    module OrmHelpers
      def model_contents
<<-CONTENT
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #          :recoverable, :rememberable, :trackable, :validatable
  #          
CONTENT
      end

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end
      
      def controller_exists?
        File.exists?(File.join(destination_root, controller_path))
      end
      
      def migration_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_ruby_gallery_create_#{table_name}.rb$/).first
      end
      
      def migration_add_columns_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_ruby_gallery_add_columns_to_#{table_name}.rb$/).first
      end
      
      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
      
      def controller_path
        @controller_path ||= File.join("app", "controllers", "#{table_name}_controller.rb")
      end
      
      
    end
  end
end