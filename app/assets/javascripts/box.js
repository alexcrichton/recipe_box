//= require jquery
//= require jquery_ujs

window.showCard = function() {
  if (!$('#card').hasClass('start'))
    $('#card').addClass('start').removeClass('end');
};

window.hideCard = function() {
  $('#card:visible').addClass('end').removeClass('start');
};

window.setContent = function(html) {
  showCard();
  $('#card').removeClass('loading').find('.content').html(html);
};

$(function() {
  $('#buttons a[data-remote]').click(showCard);
  $('#card > a.close').click(hideCard);

  $(document).delegate('a[data-remote]:not(.nomove)', 'ajax:before', function() {
    $('#card').addClass('loading').find('.content').empty();
    history.pushState({path: this.path}, '', this.href);
  });

  $(window).bind('popstate', function(event) {
    $.ajax({url:location.pathname, dataType: 'script'});
  });
});
