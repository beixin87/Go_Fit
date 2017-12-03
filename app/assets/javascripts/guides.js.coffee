$ ->
  document.addEventListener 'turbolinks:load', ->
    $('[data-provider="summernote"]').each ->
      $(this).summernote({
        height: 360

        maximumImageFileSize: 5242880    # 5242880=5M, 3145728=3M, 1048576=1M 
        callbacks: {
          onImageUploadError: -> 
           alert('Image file size limit 5MB');          
        }


      });
       
        
  