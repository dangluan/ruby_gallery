module RubyGallery::RubyGalleryHelper
  def show_gallery_images(model_name, opts={})
    object = model_name.to_s.singularize.classify.constantize.find(params[:id])
    opts = {reorder: true, multiple_upload: true}.merge(opts)
    content = ""
    content += content_tag(:div, class: "upload-box") do
      [content_tag(:div, 'Upload album', class: "legend"),
      content_tag(:div, class: "form-box") do
        [content_tag(:form, id: "fileupload", class: "fileupload", method: "POST", enctype: "multipart/form-data", action: "/#{model_name}/upload_album?id=#{params[:id]}", multipart: true) do
          content_tag(:span, id: "upload_button", class: "upload-button btn btn-success fileinput-button", status: "") do
            [content_tag(:i, "", class: "icon-plus icon-white"),
            content_tag(:span, "Upload"),
            tag(:input, class: "upload-button-input", type: :file, multiple: "multiple", name: "file[]")].join.html_safe
          end
        end,
        content_tag(:a, "Close", class: "close-link", href: "#")].join.html_safe
      end].join.html_safe +

      [content_tag(:div , id: "file_box", class: "file-box", data_model: "#{model_name}", model_id: "#{object.id}") do
         content_tag(:ul, id: "photos_album", class: "album #{opts[:reorder] ? "ruby-gallery-sortable" : ""}", data_url: "/#{model_name}/update_ruby_gallery_position?id=#{object.id}") do
          
          if object.nil? || object.album_photos.size == 0
             content_tag(:span, "No file selected", id: "no_file")
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
      end].join.html_safe 
    end
    
    content += javascript_tag(%Q[
      
      function renderPhoto(photoResult) {
        return function() {
          $('#file_box ul#photos_album li.new-photo').remove();
	  	    $('#file_box ul#photos_album').append(photoResult);
  	    }
      }
      $(function () {
        
        
        $('#fileupload').fileupload({
           dropZone: $('#fileupload'),
        	 progressInterval: 20,		
           add: function(e,data){
             if ($('span#upload_button').attr('status') == 'process'){
        	  		return false;
              } else {
        				var types = /(.)(png|jpg|gif|jpeg)$/i;
        				var file = data.files[0];
        				if (types.test(file.type) || types.test(file.name) ){
        					$('span.upload-button span').html("processing");
        					$("span#no_285.giffile").remove();
        					$("span#no_file").remove();
        	    	  $('#file_box ul#photos_album').append("<li class='photo-cat new-photo' ><div id='progress' class='pic-icon' ></div></li>");
        				  data.submit();
        	 			} else {
        				  alert("Please upload image files");
        				}
        			}
           },
        	 progressall: function(e, data){
        			var progress = parseInt(data.loaded / data.total * 100, 10);
        			$('#file_box ul#photos_album li.new-photo').find('#progress div.bar').css('width',progress + '%' );
        	 },
        	 done: function(e, data){
        		var report = '';
        		if(data.result != 'failed'){
        		  $('span#upload_button span').html("Upload");
        		  var fn = renderPhoto(data.result);
        		  $('#file_box ul#photos_album li.new-photo').fadeOut();
        		  fn.call();
        		} else {
        			$('#file_box ul#photos_album li.new-photo').html("Upload failed!");
        	  	var t = setTimeout(function(){
        					$('#file_box ul#photos_album li.new-photo').remove();
        			}, 2000);
        		}
        	 }	
        });
      });
    ])
    
    return content.html_safe
  end
end
