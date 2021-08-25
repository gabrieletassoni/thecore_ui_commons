//= require jquery
//= require jquery-ui
//= require jquery-ui/widget
//= require jquery-ui/widgets/dialog
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