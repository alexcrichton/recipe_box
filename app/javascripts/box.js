//= require <jquery>

$(function() {
  $('#buttons a').click(function() {
    $('#card').addClass('start').removeClass('end');
  });
  
  $('#card a').click(function() {
    $('#card').removeClass('start').addClass('end');
    return false;
  });
});
