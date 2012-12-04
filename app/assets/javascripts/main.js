$(function () {
        // Initialize the jQuery File Upload widget:
        $('#fileupload').fileupload({
  //          autoUpload: true,
            sequentialUploads: true,
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
            ]            
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

