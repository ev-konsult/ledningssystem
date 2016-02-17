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

  /**
  * Search for users in view tasks/new
  */
  $('#user-assign-search').click(function(e) {
    e.preventDefault();

    // Makes sure marked users stay visible
    $('#user-checkboxes input[type=checkbox]').each(function() {
      if ($(this).is(':checked')) {
        $(this).parent().addClass('chosen-user');
      } else {
        $(this).parent().removeClass('chosen-user');
      }
    });

    // Clear search result in case search has already been made
    $('#user-checkboxes label').each(function() {
      if ($(this).hasClass('chosen-user') === false) {
        $(this).hide();
      }
    });

    var searchQuery = $('#user-assign-value').val().toLowerCase();

    if (searchQuery !== "") {
      $('#user-checkboxes label').each(function() {
        // There's a checkbox nested in the label..hence regex
        var actualLabelText = $(this).html().replace(/(<([^>]+)>)/ig,"").toLowerCase();

        if (actualLabelText.indexOf(searchQuery) >= 0) {
          $(this).fadeIn();
          $(this).css('display', 'block');

          // Need to show the checkbox related to the label too
          $(this).children(":first").fadeIn();
        }
      });
    } else {
      $('#user-assign-value').attr("placeholder", "Skriv en sökning först!");
    }
  });

  /**
  * Focus the username text field when loading login form
  */
  $('#username').focus();
});

/**
* Shows the menu when resizing the window from small to wide width
*/
$(window).on('resize', function () {
  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
});
$(window).on('resize', function () {
  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
});
