//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require selectize

function readURL(input) {
  if (input.files && input.files[0]) {
    reader = new FileReader();
  }
  reader.onload = function(e) {
    var image = new Image();
    image.src = e.target.result;
    image.onload = function() {
      if (this.width > 200 || this.height > 200) {
        if (this.width > this.height) {
          $('#uploaded_photo').css('width', '200px');
          $('#uploaded_photo').css('height', 'auto');
        } else {
          $('#uploaded_photo').css('width', 'auto');
          $('#uploaded_photo').css('height', '200px');
        }
      } else {
        $('#uploaded_photo').css('width', 'auto');
        $('#uploaded_photo').css('height', 'auto');
      }
      $('#uploaded_photo').attr("src", this.src);
      $('#upload_preview').show();
    }
  }
  reader.readAsDataURL(input.files[0]);
}

$(document).on("turbolinks:load", function()  {
  var $select = $(".selectize").selectize();
});
