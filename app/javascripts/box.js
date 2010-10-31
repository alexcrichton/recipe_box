//= require <jquery>
//= require <jquery/hashchange>

$(function() {
  $('#buttons a').click(function() {
    $('#card').addClass('start').removeClass('end');
  });

  $('#card a').click(function() {
    $('#card').removeClass('start').addClass('end');
    window.location.hash = '';
    return false;
  });

  $('a[data-remote]:not(.nohash)').live('ajax:before', function() {
    window.location.hash = $(this).attr('href');
  });

  $(window).hashchange(function() {
    if (window.location.hash == '#' || window.location.hash == '') {
      return;
    }

    $('#card').addClass('start').removeClass('end');

    $.ajax({
      url: window.location.hash.substr(1),
      dataType: 'script'
    });
  }).hashchange();
});
