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

$(function() {
  $("#users th a, #users .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
    return false;
  });
});

$.lazybox.settings = { cancelClass: "pure-button", submitClass: 'pure-button pure-button-primary' }
$.rails.allowAction = $.lazybox.confirm;

