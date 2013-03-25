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
      
      
      def add_routes
        route "post '/lists/upload_album', controller: :lists, action: :upload_album"
      end
    end
  end
end