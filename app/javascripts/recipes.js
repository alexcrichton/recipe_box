//= require <jquery>
//= require <jquery/select_autocomplete>

$(function() {
  $('a.add').click(function() {
    var html = $('#new-ingredient').html();
    html = html.replace(/REPLACE_ME/g, new Date().getTime().toString());
    $('#ingredients').append(html);
    
    return false;
  });

  $(':checkbox').live('click', function() {
    $(this).parents('dd').fadeOut().prev().fadeOut();
  });
  
  $('#category select').select_autocomplete();
  $('#category a').click(function() {
    $('.new-category').fadeIn();
    $(this).parents('.select-category').fadeOut();
    return false;
  });
});
