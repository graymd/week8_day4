$(document).ready(function(){
  $('.submit').prop('disabled', true);
  $('.name_field').change(function(){
    var name = $(".name_field").val();
    if (name != "") {
      $('.submit').prop('disabled', false);
    }
    if (name == "") {
      $('.submit').prop('disabled', true);
    }
  })

  $('ul.clinic_list > li').hide();
  $('li.section_1').show();

  $('ul.link_list > li > a').click(function(){
    $('ul.clinic_list > li').hide();
    var clinic_list = $(this).attr('clinic_num')
    $('li.section_' + clinic_list).show();
  })

  var name = $(".name_field").val();
  if (name != "") {
    $('.error_name').hide();
  }


  $('.name_field').keyup(function(){
    var name = $(".name_field").val();
    if (name != "") {
      $('.error_name').hide();
    }
    else {
      $('.error_name').show();
    }
  })

});

