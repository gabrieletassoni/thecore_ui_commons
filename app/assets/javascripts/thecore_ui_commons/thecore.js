//= require jquery
//= require jquery-ui
//= require jquery-ui/widgets/dialog
//= require jquery_ujs
//= require bootstrap
//= require ie
//= require timer
//= require apexcharts

$(document).ready(function () {

  window.setTimeout(function() {
    $(".alert").fadeTo(1000, 0).slideUp(1000, function(){
        $(this).remove(); 
    });
  }, 5000);
})