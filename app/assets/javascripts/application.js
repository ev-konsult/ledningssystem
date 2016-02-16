// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tinymce
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  /**
  * Displays the education form when the show button is clicked
  */
  $('#show-education-form').click(function(event) {
    event.preventDefault();
    $(this).hide();
    $('#education-form').slideDown();
    $('#hide-education-form').show();
  });

  /**
  * Hides education form and shows the show button again
  */
  $('#hide-education-form').click(function() {
    $('#hide-education-form').hide();
    $('#education-form').slideUp(function() {
      $('#show-education-form').fadeIn();
    });
  });

$('#username').focus();

});

$(window).on('resize', function () {
  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
});
$(window).on('resize', function () {
  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
});
