//= require jquery
//= require jquery_ujs
//= require jquery.pjax
//= require recipe

window.showCard = function() {
  if (!$('#card').hasClass('start'))
    $('#card').addClass('start').removeClass('end');
};

window.hideCard = function() {
  $('#card:visible').addClass('end').removeClass('start');
  return false;
};

$(function() {
  if ($('#card .content').html().match(/^\s+$/) == null)
    $('#card').show();
  $('#buttons a').click(showCard);
  $('#card > a.close').click(hideCard);

  $(document).delegate('a:not([data-remote])', 'click', function(event) {
    $.pjax.click(event, $('#card .content'));
  });

  $(document).on('pjax:start', function() {
    $('#card').addClass('loading').find('.content').empty();
  });
  $(document).on('pjax:complete', function() {
    $('#card').removeClass('loading');
  });
});
