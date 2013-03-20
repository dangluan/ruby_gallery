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
    end
  end
end