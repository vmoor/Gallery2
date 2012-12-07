$(function () {
        // Initialize the jQuery File Upload widget:
        $('#fileupload').fileupload({
  //          autoUpload: true,
            sequentialUploads: true,
            maxChunkSize: 1000000,
            limitConcurrentUploads: 1,
            previewMaxWidth: 200,
            previewMaxHeight: 150,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                console.log(data.context.find('.bar').css('width', '25%'));
                $('#progress .bar').css(
                    'width',
                    progress + '%'
                );
                var bitrate = parseInt(data.bitrate / 1024);
                var bitrate_s = "";
                if (bitrate > 1024) {
                  bitrate = parseFloat(bitrate / 1024).toFixed(2);
                  bitrate_s = bitrate + " MiB/s";
                } else {
                  bitrate_s = bitrate + " KiB/s";
                }
                console.log(bitrate_s);
            },

            fileuploadprogress: function (e, data) {
            // Log the current bitrate for this upload:
              console.log(data.total);
            },

            process: [
              {
                  action: 'load',
                  fileTypes: /^image\/(gif|jpeg|png)$/
//                  maxFileSize: 20000000 // 20MB
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
                var rows = $();
                $.each(o.files, function (index, file) {
                    var row = $('<div class="template-upload fade">' +
                        '<li class="span3"><div class="thumbnail">' + 
                        '<div class="preview" style="text-align: center"><span class="fade"></span></div>' +
                        '<div class="name"><span></span></div>' +
                        '<div class="size"><span></span></div>' +
                        (file.error ? '<div class="error label label-important"></div>' :
                                '<div><div class="progress progress-striped active">' +
                                    '<div class="bar" style="width:0%;"></div></div></div>' +
                                    '<div class="start">' +
                                    (!o.options.autoUpload ? '<button> <i class="icon-upload icon-white"></i><span>'+ locale.fileupload.start +'</span></button>' : '<div></div>' ) + '</div>'
                        ) + '<div class="cancel"><button><i class="icon-ban-circle icon-white"></i>'+ locale.fileupload.cancel +'</button></div></div></li></div>');
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
                var row = $('<div class="template-download fade">' +
                  '<li class="span3"><div class="thumbnail">' + 
                    (file.error ? '<div></div><div class="name"></div>' +
                        '<div class="size"></div><div class="error label label-important"></div>' :
                            '<div class="preview"></div>' +
                                '<div class="name"><a></a></div>' +
                                '<div class="size"></div><div colspan="2"></div>'
                    ) + '<div class="delete"><button><i class="icon-trash icon-white"></i>'+
                    '<span>' + locale.fileupload.destroy + '</span></button> ' +
                        '<input type="checkbox" name="delete" value="1"></div></div></li></div>');
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

