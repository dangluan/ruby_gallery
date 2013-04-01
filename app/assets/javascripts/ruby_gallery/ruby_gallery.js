$(document).ready(function(){	
  
  $(document.body).delegate("a.gallery-colorbox", "click", function(e){
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
  
  $(document.body).delegate('span.remove-photo', 'click', function(e){
    var _this = this
    $.ajax({
      url: "/" + $('div.file-box').attr('data_model') + "/" + $('div.file-box').attr('model_id') + "/delete_photo?photo_id="+ $(this).attr('photo_id') ,
      type: "DELETE",
      success: function(e){
        if(e == "ok"){
          var dom = $(_this).parent().find("li.photo_" + $(_this).attr('photo_id') + "").selector.toString();
          $(dom).remove();
        }else{
          
        }
      }
    });
    e.preventDefault();
  });
  
  $(document.body).delegate('li.photo-cat a','mouseover',function(event){
     $(this).parent().find('span.remove-photo').addClass('blur');
     $(this).parent().find('span.remove-photo').removeClass('hide');    
  });
  
  $(document.body).delegate('li.photo-cat a','mouseout',function(event){
    $(this).parent().find('span.remove-photo').removeClass('blur');
    $(this).parent().find('span.remove-photo').addClass('hide');    
  });
  
  $(document.body).delegate('span.remove-photo','mouseover',function(event){
      $(this).removeClass('blur');
      $(this).removeClass('hide');    
  });
  
  $(document.body).delegate('span.remove-photo','mouseout',function(event){
    $(this).removeClass('blur');
    $(this).addClass('hide');    
    
  });
});