// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
<<<<<<< HEAD
//= require summernote
//= require_tree .
//= require jquery-ui
=======
//= require bootstrap
//= require summernote
//= require_tree .
//= require turbolinks

>>>>>>> e7629e842362b2a3c50fe57c5ff68ca01c3f3242

$(function() {
  $("#user_date_of_birth").datepicker({
  		dateFormat: 'yy-mm-dd',
  		changeMonth: true,
  		changeYear: true,
  		yearRange: '1960:',
  		maxDate: '+0',
  		minDate: '-100Y'
  	});
});
<<<<<<< HEAD
=======

>>>>>>> e7629e842362b2a3c50fe57c5ff68ca01c3f3242
