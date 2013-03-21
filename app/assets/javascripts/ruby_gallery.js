
  clearInterval(window.refeshWork);
	window.refeshWork = null;

  $('#fileupload').fileupload({
     dropZone: $('#fileupload'),
  	 progressInterval: 20,		
     add: function(e,data){
       if ($('span#upload_button').attr('status') == 'process'){
  	  		return false;
        } else {
  				var types = /(\.|\/)(png|jpg|gif|jpeg)$/i;
  				var file = data.files[0];
  				if (types.test(file.type) || types.test(file.name) ){
  					$('span.upload-button span').html("<%= t('details.processing') %>");
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
				$('span#upload_button span').html("<%= t('details.upload_picture') %>");
				$('#file_box ul#photos_album li.new-photo').fadeOut('slow', function() {

				  	$('#file_box ul#photos_album li.new-photo').remove();
				  	$('#file_box ul#photos_album').append(res);

			   });
			  
				// var t=setTimeout(function(){
				// }, 2000);	
  		} else {
  			$('#file_box ul#photos_album li.new-photo').html("<%= t('details.upload_failed') %>");
		  	var t = setTimeout(function(){
						$('#file_box ul#photos_album li.new-photo').remove();
				}, 2000);
  		}
  	 }	
  });