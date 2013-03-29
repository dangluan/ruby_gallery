module RubyGallery
  module AttachmentsController
    def upload_album_for(models)
      class_name = models.to_s.singularize
      class_object_name = class_name.classify # "Book"
      class_object = class_object_name.constantize # Book
      
      
      instance_eval do
        define_method("upload_album") do
          object = class_object.find(params[:id])
          # 10.times {
            
            photo = object.album_photos.build({photo: (params[:file] and params[:file].is_a?(Array)) ? params[:file][0] : params[:file]})
            photo.save
          # }
          
          eval("@#{class_name} = #{class_object_name}.find(params[:id])")
          render :partial => "shared/photo_box",locals: {photo: photo}
          # render text: "successful"
        end
        
        define_method("delete_photo") do
          object = class_object.find(params[:id])
          photo = object.album_photos.find(params[:photo_id])
          photo.destroy
          render text: "ok"
        end
        
        define_method("update_ruby_gallery_position") do
          object = class_object.find(params[:id])
          json = params[:json]
      	  json.each do |key,value|
      	    id = value['id']
      	    position = value['position'] 
      	    photo = object.album_photos.find(id)
      	    photo.update_attribute(:position, position)
      	  end
          render :text => "successful"
        end
        
      end
    end
  end
end