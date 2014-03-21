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


$(function() {

        $( "#search" ).autocomplete({
            source: "auto_complate#index.js",
            minLength: 1
        });
    });
});

$timeout = void 0; //устанавливаем таймер для срабатывание запроса, чтоб неспамить
  $("body").on("input", "#field", function(e) {
    clearTimeout($timeout); // сбрасуем таймер при новом вводе символа
    $timeout = setTimeout(function() { //запускаем новый таймер
      if ($("#field").val().length > 1) {
        $.ajax({
          url: $('#field').data('search-url'),// прописать урл запроса на поле ввода в дата атрибут
          data: "search=" + $("#field").val(), // в контроллер прийдет как params[:search]
          dataType: 'JSON',
          success: function(data) {
            $("#field").autocomplete({
                source: data // в data должен быть масив с контроллера
            });
          }
        });
      }
    }, 700);
  });

$.lazybox.settings = { cancelClasskey: "value",  "pure-button", submitClass: 'pure-button pure-button-primary' }
$.rails.allowAction = $.lazybox.confirm;

