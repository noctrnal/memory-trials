// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $("form").on("keypress", function (e) {
    if (e.keyCode == 13) {
      return false;
    }
  });

  $('.memory').first().toggle();

  setTimeout(function() {
    $('.memory').first().toggle();
    $('.equation').first().toggle();
    $('.sentence').first().toggle();
    $('.veracity').first().toggle();
  }, 1000);

  $('.veracity-button').click(function(event) {
    event.preventDefault();

    if($(this).parent().parent().is(':last-of-type')) {
      $(this).parent().toggle();
      $(this).parent().prev().prev().toggle();

      $('.recall').first().toggle();
    } else {
      $(this).parent().toggle();
      $(this).parent().prev().prev().toggle();

      var next = $(this).closest('div').next('div');
      next.find('.memory').toggle();

      setTimeout(function() {
        next.find('.memory').toggle();
        next.find('.equation').toggle();
        next.find('.sentence').toggle();
        next.find('.veracity').toggle();
      }, 1000);
    }
  });

  $('.recall-button').click(function(event) {
    if($(this).parent().parent().is(':last-of-type')) {
      $(this).parent().toggle();
    } else {
      event.preventDefault();
      $(this).parent().toggle();

      var next = $(this).closest('div').next('div');
      next.find('.recall').toggle();
    }
  });
});
