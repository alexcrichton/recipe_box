//= require <jquery>

$(function() {
  $('.pagination-container .pagination a').live('click', function() {
    $(this).parents('.pagination-container:first').html(
      $['huge-ajax']
    ).load($(this).attr('href'));
    return false;
  });
});
