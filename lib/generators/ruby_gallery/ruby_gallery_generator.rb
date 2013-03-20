module RubyGallery
  module Generators
    class RubyGalleryGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      
      namespace "ruby_gallery"
      
      source_root File.expand_path("../templates", __FILE__)
      
      desc "Generates RubyGallery attributes for a model given its NAME."
      
      hook_for :orm
    end
  end
end