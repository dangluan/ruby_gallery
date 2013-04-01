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

      def inject_javascript
        append_to_file 'app/assets/javascripts/application.js' do
          out = "\n"
          out << "//= require ruby_gallery/app"
        end
      end
      
      def inject_css
        append_to_file 'app/assets/stylesheets/application.css' do
          out = "\n"
          out << "/* *= require ruby_gallery/styles */"
        end      
      end
      
    end
  end
end