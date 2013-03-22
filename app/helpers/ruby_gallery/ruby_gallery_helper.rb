module RubyGallery::RubyGalleryHelper
  def show_gallery_images(model_name, opts={})
    object = model_name.to_s.singularize.classify.constantize.find(params[:id])
    content_tag(:div, class: "upload-box") do
      [content_tag(:div, 'upload album', class: "legend"),
      content_tag(:div, class: "form-box") do
        [content_tag(:form, id: "fileupload", class: "fileupload", method: "POST", enctype: "multipart/form-data", action: "/attachments/upload_album?id=#{params[:id]}") do
          content_tag(:span, id: "upload_button", class: "upload-button btn btn-success fileinput-button") do
            [content_tag(:i, "", class: "icon-plus icon-white"),
            content_tag(:span, "Upload picture"),
            tag(:input, class: "upload-button-input", type: :file, multiple: "")].join.html_safe
          end
        end,
        content_tag(:a, "Close", class: "cancel-button cancel-link", href: "#")].join.html_safe
      end].join.html_safe +
      
      content_tag(:div , id: "file_box", class: "file-box") do
        content_tag(:ul, id: "photos_album", class: "album") do
          
        end
      end
    
    end
  end
end
