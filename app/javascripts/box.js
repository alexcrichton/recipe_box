//= require <jquery>

$(function() {
  $('#buttons a[data-remote]').click(function() {
    $('#card').addClass('start').removeClass('end');
  });

  $('#card > a.close').click(function() {
    $('#card').removeClass('start').addClass('end');
  });

  $('a[data-remote]:not(.nohash)').live('ajax:before', function() {
    $('#card').addClass('loading').find('.content').empty();
    history.pushState({path: this.path}, '', this.href);
  }).live('ajax:complete', function() {
    $('#card').removeClass('loading');
  });

  $(window).bind('popstate', function(event) {
    $.get(location.pathname);
  });
});
