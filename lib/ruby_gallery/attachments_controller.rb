module RubyGallery
  module AttachmentsController
    def upload_album_for(models)
      instance_eval do
        define_method("upload_album") do
          puts models
          object = models.to_s.singularize.classify.constantize.find(params[:id])
          photo = object.album_photos.new(photo: params[:file])
          photo.save(validate: false)
        end
      end
    end
  end
end