//= require <jquery>

$(function() {
  $('#buttons a').click(function() {
    $('#card').addClass('start').removeClass('end');
  });

  $('#card a').click(function() {
    $('#card').removeClass('start').addClass('end');
    window.location.hash = '';
    return false;
  });

  $('a[data-remote]').live('ajax:before', function() {
    window.location.hash = $(this).attr('href');
  });

  if (window.location.hash != '#' && window.location.hash != '') {
    $('#buttons a:first').click();
    $.ajax({
      url: window.location.hash.substr(1),
      dataType: 'script'
    });
  }
});
