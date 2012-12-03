jQuery(function($){
	 $('a[data-photo-destroy-id]').live('click', function(){
		var a = $(this);
      $.ajax({
        data: {"_method":"delete"},
        type: 'post',
        url: a.attr("href"),
        success: process
      });
      return false;
    });

	 function process(data){
	 	$('div[data-photo-id=' + data.photo.id + ']').remove();
	 }
});