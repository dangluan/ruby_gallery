class RubyGalleriesController::AttachmentsController < ApplicationController
  def self.upload_album
    puts params[:id]
  end
end