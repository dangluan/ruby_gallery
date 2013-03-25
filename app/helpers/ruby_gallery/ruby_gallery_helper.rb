module RubyGallery::RubyGalleryHelper
  def show_gallery_images(model_name, opts={})
    object = model_name.to_s.singularize.classify.constantize.find(params[:id])
    content = ""
    content += content_tag(:div, class: "upload-box") do
      [content_tag(:div, 'upload album', class: "legend"),
      content_tag(:div, class: "form-box") do
        [content_tag(:form, id: "fileupload", class: "fileupload", method: "POST", enctype: "multipart/form-data", action: "/attachments/upload_album?id=#{params[:id]}") do
          content_tag(:span, id: "upload_button", class: "upload-button btn btn-success fileinput-button", status: "") do
            [content_tag(:i, "", class: "icon-plus icon-white"),
            content_tag(:span, "Upload picture"),
            tag(:input, class: "upload-button-input", type: :file, multiple: "", name: "file[]")].join.html_safe
          end
        end,
        content_tag(:a, "Close", class: "cancel-button cancel-link", href: "#")].join.html_safe
      end].join.html_safe +
      
      
      
      [content_tag(:div , id: "file_box", class: "file-box") do
        content_tag(:ul, id: "photos_album", class: "album") do
          
        end
      end].join.html_safe 
    end
    
    content += javascript_tag(%Q{
      $('#fileupload').fileupload({
         dropZone: $('#fileupload'),
      	 progressInterval: 20,		
         add: function(e,data){
           console.log('aa');
           if ($('span#upload_button').attr('status') == 'process'){
      	  		return false;
            } else {
      				var types = "/(\.|\/)(png|jpg|gif|jpeg)$/i";
      				var file = data.files[0];
      				if (types.test(file.type) || types.test(file.name) ){
      					$('span.upload-button span').html("Processing");
      					$("span#no-file").remove();
      	    	  $('#file_box ul#photos_album').append("<li class='photo-cat new-photo' ><div id='progress' class='pic-icon' ></div></li>");
      				  data.submit();
      	 			} else {
      				  alert("<%= t('details.please_upload_image_file')%>");
      				}
      			}
         },
      	 progressall: function(e, data){
      			//   		  var progress = parseInt(data.loaded / data.total * 100, 10);
      			// $('#file_box ul#photos_album li.new-photo').find('#progress div.bar').css('width',progress + '%' );
      	 },
      	 done: function(e, data){

      		var report = '';
      		if(data.result != 'failed'){
      		  var res = data.result;
      			$('span#upload_button span').html("Upload picture");
      			$('#file_box ul#photos_album li.new-photo').fadeOut('slow', function() {

      			  	$('#file_box ul#photos_album li.new-photo').remove();
      			  	$('#file_box ul#photos_album').append(res);

      		   });

      			// var t=setTimeout(function(){
      			// }, 2000);	
      		} else {
      			$('#file_box ul#photos_album li.new-photo').html("Upload failed!");
      	  	var t = setTimeout(function(){
      					$('#file_box ul#photos_album li.new-photo').remove();
      			}, 2000);
      		}
      	 }	
      });
    })
    
    return content.html_safe
  end
end
