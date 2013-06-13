module RubyGallery::RubyGalleryHelper
  def show_gallery_images(model_obj, opts={})
    # object = model_name.to_s.singularize.classify.constantize.find_by_id(parent_model_id)
    object = model_obj
    model_name = model_obj.class.to_s.tableize
    opts = {reorder: true, close: true}.merge(opts)
    content = ""
    content = content_tag(:div, class: "upload-box") do
      [
        content_tag(:div, t("ruby_gallery.web_content.upload_album"), class: "legend"),
        content_tag(:div, class: "form-box") do
          [
            content_tag(:form, id: "fileupload", class: "fileupload", method: "POST", enctype: "multipart/form-data", action: "/#{model_name}/upload_album?id=#{model_obj.id}", multipart: true) do
              content_tag(:span, id: "upload_button", class: "upload-button btn btn-success fileinput-button", status: "") do
                [content_tag(:i, "", class: "icon-plus icon-white"),
                content_tag(:span, t("ruby_gallery.web_content.upload_button")),
                tag(:input, class: "upload-button-input", type: :file, multiple: "multiple", name: "file[]", accept: "image/*")].join.html_safe
              end
            end,
            opts[:close] ? content_tag(:a, t("ruby_gallery.web_content.close_link"), class: "close-link", href: "#") : ""
            
          ].join.html_safe
        end, # end form-box
        content_tag(:div, class: "nano") do
          content_tag(:div , id: "file_box", class: "file-box overthrow content description", data_model: "#{model_name}", model_id: "#{object.id}") do
            content_tag(:ul, id: "photos_album", class: "album #{opts[:reorder] ? "ruby-gallery-sortable" : ""}", data_url: "/#{model_name}/update_ruby_gallery_position?id=#{object.id}") do
          
              if object.nil? || object.album_photos.size == 0
                 content_tag(:span, t("ruby_gallery.web_content.no_file_selected"), id: "no_file")
              else
                img_array = []
                object.album_photos.order("position ASC").each do |photo|
                  img_array.push(content_tag(:li, class: "photo-cat photo_#{photo.id}" , key: "#{photo.id}") do
                    [content_tag(:span, raw("&#10006;"), class: "entypo-icon-1 remove-photo hide", photo_id: photo.id),
                    content_tag(:a, class: "gallery-colorbox", href: "#{photo.photo.url(:original)}") do
                      tag(:img, src: photo.photo.url(:medium), width: '120', height: '120', rel: "ruby_gallery")
                    end,
                    tag(:input, type: :hidden, name: "position-item", class: "item-position", value: "#{photo.position}")
                    ].join.html_safe
                  end)
                end
                 img_array.join.html_safe # conclude what to be displayed
              end
            end
          end
        end, # end nano-scrollbar
        content_tag(:div, class: "ruby-gallery-translation hide") do
          [
            content_tag(:div, t("ruby_gallery.web_content.please_upload_image_files"), id: "please_upload_image_files_text"),
            content_tag(:div, t("ruby_gallery.web_content.processing"), id: "processing_text"),
            content_tag(:div, t("ruby_gallery.web_content.upload_button"), id: "upload_button_text"),
            content_tag(:div, t("ruby_gallery.web_content.upload_failed"), id: "upload_failed_text")
          ].join.html_safe
        end # end ruby-gallery-translation
      ].join.html_safe
    end
    
    content += javascript_tag(%Q{
      jQuery(function ($) {
        RubyGallery.init();
      });
    })
    
    return content.html_safe
  end
end
