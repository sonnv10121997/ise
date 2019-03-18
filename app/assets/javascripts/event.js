$(document).on('turbolinks:load', function() {
  $('.tab').on('click', function() {
    $('.tab').removeClass('button button-text').addClass('btn button-text-default');
    $(this).removeClass('btn button-text-default').addClass('button button-text');
    var clickedIndex = $('.tab').index(this);

    var panels = $('.tab_panel');
    panels.removeClass('active');
    $(panels[clickedIndex]).addClass('active');
  });
});
