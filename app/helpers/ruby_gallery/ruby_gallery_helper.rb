module RubyGallery::RubyGalleryHelper
  def show_gallery_images(model_name, opts={})
    object = model_name.to_s.singularize.classify.constantize.find(params[:id])
    content_tag(:div, class: "upload-box") do
      content_tag(:div, class: "legend", "#{t('details.upload_album')}"),
      content_tag(:div, class: "form-box") do
        content_tag(:form, id: "fileupload", class: "fileupload", method: "POST", enctype: "multipart/form-data") do
          
        end
      end
    end
  end
end