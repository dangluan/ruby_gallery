require 'rubygems'
require 'jquery-fileupload-rails'
require 'paperclip'
require 'bourbon'
require 'ruby_gallery/attachments_controller'

module RubyGallery  
  class Engine < Rails::Engine
    ActionController::Base.send(:extend, RubyGallery::AttachmentsController)
    # same as ActionController::Base.extend(RubyGallery::AttachmentsController)
  end
end