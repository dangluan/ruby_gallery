require 'securerandom'
require 'rails/generators'
require 'rails/generators/migration'

module RubyGallery
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../../templates", __FILE__)
      
      desc "Creates a Congig file and copy locate files to your application."
      
      class_option :orm
      
      def copy_jsfile
        copy_file "../../../app/assets/javascripts/ruby_gallery.js", "app/assets/javascripts/ruby_gallery.js"
      end
      
      def copy_cssfile
        copy_file "../../../app/assets/stylesheets/ruby_gallery.css.scss", "app/assets/stylesheets/ruby_gallery.css.scss"
      end
      
      def copy_imgfile
        copy_file "../../../app/assets/images/upload_processing.gif", "app/assets/images/upload_processing.gif"
      end
      
      
      
      def inject_javascript
        append_to_file 'app/assets/javascripts/application.js' do
          out = "\n"
          out << "//= require ruby_gallery"
        end
        
        append_to_file 'app/assets/javascripts/application.js' do
          out = "\n"
          out << "//= require jquery-fileupload/basic"
        end
        
      end
      
      def inject_css
        append_to_file 'app/assets/stylesheets/application.css' do
          out = "\n"
          out << "/* *= require ruby_gallery */"
        end
        
        append_to_file 'app/assets/stylesheets/application.css' do
          out = "\n"
          out << "/* *= require jquery.fileupload-ui */"
        end
      end
      
    end
  end
end