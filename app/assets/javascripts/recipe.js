$(function() {
  $(document).delegate('form a.add', 'click', function() {
    var html = $('#new-ingredient').html();
    html = $(html.replace(/REPLACE_ME/g, new Date().getTime().toString()));
    $('#ingredients').append(html);
    html.find('.quantity').focus();

    return false;
  });

  $(document).delegate('#ingredients .close', 'click', function() {
    $(this).parents('.ingredient').hide().find('.remove').val('1');
    return false;
  });

  $(document).delegate('#ingredients input[type=text]', 'keydown', function(e) {
    if (e.keyCode == 13) { // enter key
      var $parent = $(e.srcElement).parents('div.ingredient');

      if ($parent.next().length == 0) {
        $('#ingredients a').click();
        e.preventDefault();
      }
    }
  });

});
