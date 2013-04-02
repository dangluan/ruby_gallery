var RubyGallery = {
  init: function() {
    $(document.body).delegate("div.upload-box a.gallery-colorbox", "click", function(e){
      $(this).colorbox({rel: "ruby_gallery"});
      e.preventDefault();
    });

    $('ul.ruby-gallery-sortable').sortable({
      stop: function(event, ui){
        $('ul.ruby-gallery-sortable').children().each(function(index){
          $(this).find('input[name="position-item"]').val(index);
        });
        var arr_pos = []
      	 $(':hidden[name^="position-item"]').each(function(){
      	  arr_pos.push($(this).val());
      	 });

      	 var arr_key = $("li.photo-cat").map(function(){
           return this.getAttribute("key");
         }).get();
         var json_str = "";
         for(var i = 0; i < arr_pos.length && arr_key.length; i ++ ) {
           json_str += "{'id':'" + arr_key[i] + "', 'position':'" + arr_pos[i] + "'},"
         }
         var json = eval("[" + json_str + "]")
        $.ajax({
          url: $("ul#photos_album").attr("data_url"),
          data: {'json': json},
          type: "PUT",
          success: function(res){
          }
        })
      }
    });

    $(document.body).delegate('div.upload-box span.remove-photo', 'click', function(e){
      var _this = this
      $.ajax({
        url: "/" + $('div.file-box').attr('data_model') + "/" + $('div.file-box').attr('model_id') + "/delete_photo?photo_id="+ $(this).attr('photo_id') ,
        type: "DELETE",
        success: function(e){
          if(e == "ok"){
            var dom = $(_this).parent().find("li.photo_" + $(_this).attr('photo_id') + "").selector.toString();
            $(dom).remove();
            $("div.upload-box div.nano").nanoScroller();
          } else{

          }
        }
      });
      e.preventDefault();
    });

    $(document.body).delegate('div.upload-box li.photo-cat a','mouseover',function(event){
       $(this).parent().find('span.remove-photo').addClass('blur');
       $(this).parent().find('span.remove-photo').removeClass('hide');    
    });

    $(document.body).delegate('div.upload-box li.photo-cat a','mouseout',function(event){
      $(this).parent().find('span.remove-photo').removeClass('blur');
      $(this).parent().find('span.remove-photo').addClass('hide');    
    });

    $(document.body).delegate('div.upload-box span.remove-photo','mouseover',function(event){
        $(this).removeClass('blur');
        $(this).removeClass('hide');
    });

    $(document.body).delegate('div.upload-box span.remove-photo','mouseout',function(event){
      $(this).removeClass('blur');
      $(this).addClass('hide');    

    });
    
    this.initializeFileUpload();
  },
  
  translatedText: function(key) {
    return $("div.ruby-gallery-translation #" + key + "_text").text();
  },
  
  renderPhoto: function(photoResult) {
    $('#file_box ul#photos_album li.new-photo').remove();
    $('#file_box ul#photos_album').append(photoResult);
  },
  
  initializeFileUpload: function() {
    var _this = this;
    $('#fileupload').fileupload({
       dropZone: $('#file_box'),
    	 progressInterval: 20,		
       add: function(e,data){
         if ($('span#upload_button').attr('status') == 'process'){
    	  		return false;
          } else {
    				var types = /(.)(png|jpg|gif|jpeg)$/i;
    				var file = data.files[0];
    				if (types.test(file.type) || types.test(file.name) ){
    					$('span.upload-button span').html(_this.translatedText("processing"));
    					$("span#no_285.giffile").remove();
    					$("span#no_file").remove();
    	    	  $('#file_box ul#photos_album').append("<li class='photo-cat new-photo' ><div id='progress' class='pic-icon' ></div></li>");
    				  data.submit();
    	 			} else {
    				  alert(_this.translatedText("please_upload_image_files"));
    				}
    			}
       },
    	 progressall: function(e, data){
    			var progress = parseInt(data.loaded / data.total * 100, 10);
    			$('#file_box ul#photos_album li.new-photo').find('#progress div.bar').css('width',progress + '%' );
    	 },
    	 done: function(e, data){
    		if(data.result != 'failed'){
    		  $('span#upload_button span').html(_this.translatedText("upload_button"));
    		  $('#file_box ul#photos_album li.new-photo').fadeOut();
    		  RubyGallery.renderPhoto(data.result);
    		  $("div.upload-box div.nano").nanoScroller();
    		} else {
    			$('#file_box ul#photos_album li.new-photo').html(_this.translatedText("upload_failed"));
    	  	var t = setTimeout(function(){
    					$('#file_box ul#photos_album li.new-photo').remove();
    			}, 2000);
    		}
    	 }	
    });
  }
}