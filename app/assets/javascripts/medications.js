$(document).ready(function(){
  $('ul.medication_list > li').hide();
  $('li.section_1').show();

$("ul.link_list > li > a").click(function() {
  $("ul.medication_list > li").hide();
  var medication_list = $(this).attr("med_num");
  $("li.section_" + medication_list).show();
})  

  var name = $(".name_field").val();
  if (name != "") {
    $('.error_name').hide();
  }
  $('.name_field').keyup(function(errorNameCheck){
    var name = $(".name_field").val();
    if (name != "") {
      $('.error_name').hide();
    }
    else {
      $('.error_name').show();
    }
  })

})
