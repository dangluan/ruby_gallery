$(document).ready(function(){
  
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
  
  $(document.body).delegate('li.photo-cat img','mouseover',function(event){
     $(this).parent().find('span.remove-photo').addClass('blur');
     $(this).parent().find('span.remove-photo').removeClass('hide');    
  });
  
  $(document.body).delegate('li.photo-cat img','mouseout',function(event){
    $(this).parent().find('span.remove-photo').removeClass('blur');
    $(this).parent().find('span.remove-photo').addClass('hide');    
  });
  
  $(document.body).delegate('span.remove-photo','mouseover',function(event){
      $(this).removeClass('blur');
      $(this).removeClass('hide');    
  });
  
  $(document.body).delegate('span.remove-photo','mouseout',function(event){
    $(this).addClass('blur');
    $(this).removeClass('hide');    
    
  });
});