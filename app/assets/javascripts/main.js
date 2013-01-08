jQuery(function ($) {
        // Initialize the jQuery File Upload widget:
        var fotos_up_Count = 0;
        var files_to_Upload = 0;
        var fotos_down_Count = 0;

        $('#files-to-upload-field').change(function () {
            files_to_Upload = this.files.length;
            fotos_up_Count = 0;
            fotos_down_Count = 0;
            $('#file-upload-infos').removeClass('hide');

        });

        $('#fileupload').fileupload({
            autoUpload: true,
            sequentialUploads: true,
 //           maxChunkSize: 500000,
            limitConcurrentUploads: 1,
            previewMaxWidth: 200,
            previewMaxHeight: 150,
            previewAsCanvas: false,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,

            progressall: function (e, data) {
              console.log("All");
              console.log(data);

         
                var progress = parseInt(data.loaded / data.total * 100, 10);

   /*             $('#progress-all .bar').css(
                    'width',
                    progress + '%'
                );
   */             var bitrate = parseInt(data.bitrate / 1024);
                var bitrate_s = "";
                if (bitrate > 1024) {
                  bitrate = parseFloat(bitrate / 1024).toFixed(2);
                  bitrate_s = bitrate + " MiB/s";
                } else {
                  bitrate_s = bitrate + " KiB/s";
                }
  
              $('#fileupload-loading').empty();
              $('#fileupload-loading').append('<p>'+ bitrate_s+' / ' + data.loaded+' von ' +data.total+ ' / ' +progress+'%  fotos: ' +fotosCount+'</p>');
   
            },

            completed: function (e, data) {
              console.log('upload completed');
            },

            progress: function (e, data) {
            // Log the current bitrate for this upload:
            //  console.log(data);
            },

            process: [
              {
                  action: 'load',
                  fileTypes: /^image\/(gif|jpeg|png)$/,
                  maxFileSize: 15000000 // 15 MB
              },
              {
                  action: 'resize',
                  maxWidth: 1920,
                  maxHeight: 1200
              },
              {action: 'save'}
            ],

            uploadTemplateId: null,
            downloadTemplateId: null,
            uploadTemplate: function (o) {
              fotos_up_Count++;

              $('#file-upload-infos-titel').empty();
              $('#file-upload-infos-titel').append('<h5> Bilder werden verarbeitet ('+ parseInt((((fotos_up_Count + fotos_down_Count) /(files_to_Upload*2))*100), 10) + '%)</h5>');
              $('#file-upload-infos-up').empty();
              $('#file-upload-infos-up').append('<h5>' +fotos_up_Count + ' von ' + files_to_Upload +' wurden verarbeitet</h5>');
              $('#progress-all .bar').css(
                    'width',
                    (((fotos_up_Count + fotos_down_Count) /(files_to_Upload*2))*100) + '%'
              );
               
                var rows = $();
                $.each(o.files, function (index, file) {
                    var row = $('<div class="template-upload fade">' +
                        '<div class="span3" style="height:200px;"><div class="thumbnail" style="height:200px;">' +
                        '<div class="bild" style="height:180px;"><div class="preview"><span class="fade"></span></div>' +
                        '<div class="progress progress-striped active">' +
                        '<div class="bar" style="width:0%;"></div></div>' +
                        '<div class="name"><span></span></div>' +
                        (file.error ? '<div class="error label label-important"></div>' :
                                '</div><div class="buttons"><div class="start">' +
                                    (!o.options.autoUpload ? '<button> <i class="icon-upload icon-white"></i><span>'+
                                      locale.fileupload.start +'</span></button>' : '<div></div>' ) + '</div>'
                        ) + '<div class="cancel"><button class="btn btn-orange"><i class="icon-ban-circle icon-white"></i>'+
                        locale.fileupload.cancel +'</button></div>'+
                          '</div></div></div></div>');
                    row.find('.name').text(file.name);
//                    row.find('.size').text(o.formatFileSize(file.size));
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
              fotos_down_Count++;

              $('#file-upload-infos-titel').empty();
              $('#file-upload-infos-titel').append('<h5> Bilder werden verarbeitet ('+ parseInt((((fotos_up_Count + fotos_down_Count) /(files_to_Upload*2))*100), 10) + '%)</h5>');
             
              $('#file-upload-infos-down').empty();
              $('#file-upload-infos-down').append('<h5>' +fotos_down_Count + ' von ' + files_to_Upload +' wurden hochgeladen</h5>');
              

              if(fotos_down_Count == files_to_Upload) {
                $('#file-upload-infos').addClass('hide');
                $('#file-upload-infos-up').empty();
                $('#file-upload-infos-down').empty();
                 $('#file-upload-infos-titel').empty();

                $('#progress-all .bar').css(
                    'width', '0%'
              );

              }

              var rows = $();
              $.each(o.files, function (index, file) {
                var row = $('<div class="template-download fade">' +
                              '<li class="span3" style="height:200px;">' +
                                '<div class="thumbnail" style="height:200px;">' +
                                  '<div class="bild" style="height:180px;">' +
                                    (file.error ? '<div></div><div class="name"></div>' +
                                        '<div class="size"></div><div class="error label label-important"></div>' :
                                      '<div class="preview"></div>' +
                                      '<div class="name"><a></a></div>' +
                                  '</div>'
                                    ) +
            //                    '<div class="downl-buttons"> +
                                  '<div class="delete">' +
                                  '<button class="hide">' +
//                                  '<i class="icon-trash icon-white"></i>'+
            //                    '<span>' + locale.fileupload.destroy + '</span>'+
                                  '</button>' +//<br /> ' +
                                    '<input type="checkbox" name="delete" value="1">' +
                                  '</div>' +
                                '</div>' +
                              '</li>' +
                            '</div>');
  //              row.find('.size').text(o.formatFileSize(file.size));
                if (file.error) {
                    row.find('.name').text(file.name);
                    row.find('.error').text(
                        locale.fileupload.errors[file.error] || file.error
                    );
                } else {
 //                   row.find('.name a').text(file.name); name als link
                    row.find('.name').text(file.name);
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
        //
        // Load existing files:
        $.getJSON($('#fileupload').prop('action'), function (files) {
          var fu = $('#fileupload').data('fileupload'),
            template;
          fu._adjustMaxNumberOfFiles(-files.length);
          template = fu._renderDownload(files)
            .appendTo($('#fileupload .files'));
          // Force reflow:
          fu._reflow = fu._transition && template.length &&
            template[0].offsetWidth;
          template.addClass('in');
          $('#loading').remove();
        });

});

