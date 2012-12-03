/*jQuery(function($){
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


  $('#fileupload').fileupload({
    //  dataType: "script",
     // sequentialUploads: true,
     // limitConcurrentUploads: 1,
     // autoUpload: true,
      uploadTemplateId: null,
      downloadTemplateId: null,
      uploadTemplate: function (o) {
          var rows = $();
          $.each(o.files, function (index, file) {
              var row = $('<tr class="template-upload fade">' +
                  '<td class="preview"><span class="fade"></span></td>' +
                  '<td class="name"></td>' +
                  '<td class="size"></td>' +
                  (file.error ? '<td class="error" colspan="2"></td>' :
                          '<td><div class="progress">' +
                              '<div class="bar" style="width:0%;"></div></div></td>' +
                              '<td class="start"><button>Start</button></td>'
                  ) + '<td class="cancel"><button>Cancel</button></td></tr>');
              row.find('.name').text(file.name);
              row.find('.size').text(o.formatFileSize(file.size));
              if (file.error) {
                  row.find('.error').text(
                      locale.fileupload.errors[file.error] || file.error
                  );
              }
              rows = rows.add(row);
          });
          return rows;
      },
      downloadTemplate: function (o) {
          var rows = $();
          $.each(o.files, function (index, file) {
              var row = $('<tr class="template-download fade">' +
                  (file.error ? '<td></td><td class="name"></td>' +
                      '<td class="size"></td><td class="error" colspan="2"></td>' :
                          '<td class="preview"></td>' +
                              '<td class="name"><a></a></td>' +
                              '<td class="size"></td><td colspan="2"></td>'
                  ) + '<td class="delete"><button>Delete</button> ' +
                      '<input type="checkbox" name="delete" value="1"></td></tr>');
              row.find('.size').text(o.formatFileSize(file.size));
              if (file.error) {
                  row.find('.name').text(file.name);
                  row.find('.error').text(
                      locale.fileupload.errors[file.error] || file.error
                  );
              } else {
                  row.find('.name a').text(file.name);
                  if (file.thumbnail_url) {
                      row.find('.preview').append('<a><img></a>')
                          .find('img').prop('src', file.thumbnail_url);
                      row.find('a').prop('rel', 'gallery');
                  }
                  row.find('a').prop('href', file.url);
                  row.find('.delete button')
                      .attr('data-type', file.delete_type)
                      .attr('data-url', file.delete_url);
              }
              rows = rows.add(row);
          });
          return rows;
      }
  });

});
*/
