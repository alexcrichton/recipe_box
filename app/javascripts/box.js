//= require <jquery>

window.showCard = function() {
  $('#card:visible').addClass('start').removeClass('end');
};

window.hideCard = function() {
  $('#card:visible').addClass('end').removeClass('start');
};

$(function() {
  $('#buttons a[data-remote]').click(showCard);
  $('#card > a.close').click(hideCard);

  $('a[data-remote]:not(.nomove)').live('ajax:before', function() {
    $('#card').addClass('loading').find('.content').empty();
    history.pushState({path: this.path}, '', this.href);
  }).live('ajax:complete', function() {
    $('#card').removeClass('loading');
  });

  $(window).bind('popstate', function(event) {
    $.ajax({url:location.pathname, dataType: 'script'});
  });
});
