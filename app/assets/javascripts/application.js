// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require lazybox
//= require autocomplete-rails
//= require_tree .

$(document).ready(function(){
  $('.open_popup').click(function() {
    var popup_id = $('#' + $(this).attr("rel"));
    $(popup_id).show();
    $('.overlay').show();
  })
  $('.popup .close, .overlay').click(function() {
    $('.overlay, .popup').hide();
  })

  $("#sortable").sortable({
      update: function(event, ui) {
        return $.post($(this).data('update-url'), $(this).sortable('serialize'));
        console.log(str);
        $.ajax({
          url: "#{users_path}",
          data: str 
        });
      }
    })
  
$("#big-search-box").bind("keyup", function() {

  $("#big-search-box").addClass("loading"); // show the spinner
  var form = $("#live-search-form"); // grab the form wrapping the search bar.

  var url = "/tasks/live_search"; // live_search action.   
  var formData = form.serialize(); // grab the data in the form   
  $.get(url, formData, function(html) { // perform an AJAX get

    $("#big-search-box").removeClass("loading"); // hide the spinner

    $("#live-search-results").html(html); // replace the "results" div with the results

  });

}); 

  $.lazybox.settings = { cancelClass: "pure-button", submitClass: 'pure-button pure-button-primary' }
  $.rails.allowAction = $.lazybox.confirm;


});
