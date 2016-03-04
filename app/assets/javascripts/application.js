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
//= require chartkick
//= require_tree .

$(document).ready(function() {

  /**
  * Change the greeting message dependent on time
  */
  var day = new Date().getHours();
  var greeting = "test";

  if (day >= 5 && day < 9) {
    greeting = "God morgon";
  } else if (day >= 9 && day < 12) {
      greeting = "God förmiddag";
  } else if (day >= 12 && day < 15) {
      greeting = "God dag";
  } else if (day >= 15 && day < 19) {
      greeting = "God eftermiddag";
  } else if (day >= 19 && day < 22) {
      greeting = "God kväll";
  } else {
      greeting = "God natt";
  }

  $('.greeting').html(greeting);

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
  * Hides checkboxes that aren't checked in tasks/new and tasks/edit views
  */
  function hideCheckboxes() {
    $('.user-checkbox-area').each(function() {
      if ($(this).children()[1].checked === false) {
        $(this).hide();
      }
    });
  }

  hideCheckboxes();

  /**
  * Search for users in view tasks/new and tasks/edit
  */
  $('#user-assign-search').click(function(e) {
    e.preventDefault();

    // Hide previous search results unless the checkboxes are checked
    hideCheckboxes();

    var searchQuery = $('#user-assign-value').val().toLowerCase();

    if (searchQuery !== "") {
      $('.user-info').each(function() {
        if ($(this).html().toLowerCase().indexOf(searchQuery) >= 0) {
          $(this).parent().fadeIn();
        }
      });
    } else {
      $('#user-assign-value').attr("placeholder", "Skriv en sökning först!");
    }
  });

  /**
  * Shows search query in users/index view
  */
  $('#user-search-index').click(function() {
    var searchQuery = $('#user-search-field').val();

    if (searchQuery !== undefined && searchQuery !== '') {
      $('#search-query-placeholder').html('Sökning: ' + searchQuery);
    } else {
      $('#search-query-placeholder').html('');
    }
  });

  /**
  * Focus the username text field when loading login form
  */
  $('#username').focus();

  //Enable tooltip
   $('[data-toggle="tooltip"]').tooltip();
});

/**
* Shows the menu when resizing the window width from small to wide
*/
var width = $(window).width();

$(window).on('resize', function () {
  if($(this).width() != width){
      width = $(this).width();
      if ($(window).width() > 768) $('#sidebar-collapse').collapse('show');
    }
});
$(window).on('resize', function () {
  if($(this).width() != width){
      width = $(this).width();
      if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide');
    }
});
