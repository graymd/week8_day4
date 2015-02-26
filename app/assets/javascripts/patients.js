$(document).ready(function(){

  //enforces a change on first or last name prior to allowing submittal by disabling submit button
  $('.submit').prop('disabled', true);
  $('.name_field').change(function(){
    var first_name = $(".name_field:first").val();
    var last_name = $(".name_field:last").val();
    if (first_name != "" || last_name != "") {
      $('.submit').prop('disabled', false);
    }
    if (first_name == "" || last_name == "") {
      $('.submit').prop('disabled', true);
    }
  })

  //sets fadeout on alerts and notice
  $(".alert").fadeOut(5000);
  $(".notice").fadeOut(5000);

  //sets whether or not information required
  var first_name = $(".name_field:first").val();
  var last_name = $(".name_field:last").val(); 
  if (first_name != "") {
    $('.error_first_name').hide();
  }
  if (last_name != "") {
    $('.error_last_name').hide();
  }

  //checks whether or not information required to be entered each keyup inside first and last name fields
  $('.name_field').keyup(function(){
    var first_name = $(".name_field:first").val();
    var last_name = $(".name_field:last").val();
    
    if (first_name != "") {
      $('.error_first_name').hide();
    }

    else {
      $('.error_first_name').show();
    }

    if (last_name != "") {
      $('.error_last_name').hide();
    }

    else {
      $('.error_last_name').show();
    }

  });

  // Pagination:
  // Hide the whole patient index section
  $('ul.patient_list > li').hide();
  // Show the first li in the patient index section
  $('li.section_1').show();

  //sets click event on links on index page to show applicable page
$("ul.link_list > li > a").click(function() {
  $("ul.patient_list > li").hide();
  var patient_list = $(this).attr("patient_num");
  $("li.section_" + patient_list).show();
});

  // $.paginate = function(){
  //   $('ul.patient_list > li').hide();
  //   $('li.section_1').show();
  //   $("ul.link_list > li > a").click(function() {
  //     $("ul.patient_list > li").hide();
  //     var patient_list = $(this).attr("patient_num");
  //   $("li.section_" + patient_list).show();
  //   });
  // }; 

  // $('.index-data').paginate 

});


// $(document).ready(function(){
//   $('#create').click(function(){
//     validateForm();
//   });
//   $('.error-clinic').delay(1000).fadeOut();

// function validateForm(){

//   var name = $('#nameInput').val();

//   if (name == ""){
//     $('#nameInput').after('Please enter a name')
//   }
// }

// });


// $('.name_field').on('input', function(){
//     var input = $(this);
//     var is_name=input.val();
//     if(is_name){input.removeClass("invalid").addClass("valid");}
//     else{input.removeClass("valid").addClass("invalid");}
//     })

// <!--Name can't be blank-->
// $('#contact_name').on('input', function() {
//     var input=$(this);
//     var is_name=input.val();
//     if(is_name){input.removeClass("invalid").addClass("valid");}
//     else{input.removeClass("valid").addClass("invalid");}
// });



$(document).on('click', '.to-doctor', function(){
  var patient_id = $(this).attr("patient_id");
  var clinic_id = $(this).attr("clinic_id");
  var state = {
    workflow_state: "doctor_checkup"
  };
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/to_doctor_patient',
    dataType: 'script'
    // data: {workflow_state: state}
  });
});

$(document).on('click', '.to-xray', function(){
  var patient_id = $(this).attr("patient_id");
  var clinic_id = $(this).attr("clinic_id");
  var state = {
    workflow_state: "xray"
  };
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/to_xray_patient'
,   dataType: 'script'
    // data: {workflow_state: state}
  });
});

$(document).on('click', '.to-surgery', function(){
  var patient_id = $(this).attr("patient_id");
  var clinic_id = $(this).attr("clinic_id");
  var state = {
    workflow_state: "surgery"
  };
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/to_surgery_patient',
    dataType: 'script'
    // data: {workflow_state: state}
  });
});

$(document).on('click', '.to-waiting-room', function(){
  var patient_id = $(this).attr("patient_id");
  var clinic_id = $(this).attr("clinic_id");
  var state = {
    workflow_state: "waiting_room"
  };
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/wait_patient',
    dataType: 'script'
    // data: {workflow_state: state}
  });
});

$(document).on('click', '.to-leave', function(){
  var patient_id = $(this).attr("patient_id");
  var clinic_id = $(this).attr("clinic_id");
  var state = {
    workflow_state: "left"
  };
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/leave_patient',
    dataType: 'script'
    // data: {workflow_state: state}
  });
});

$(document).on('click', '.to-pay-bill', function(){
  var patient_id = $(this).attr("patient_id");
  var clinic_id = $(this).attr("clinic_id");
  var state = {
    workflow_state: "pay_bill"
  };
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/to_pay_bill_patient',
    dataType: 'script'
    // data: {workflow_state: state}
  });
});

jQuery.ajaxSetup({ cache: true });
$(document).on('click', '.search-submit', function(){
  var searchSubmission = $('#srch-term').val();
  var clinic_id = $(this).attr('clinic_id');
  $.ajax({
    type: 'GET',
    url: '/clinics/' + clinic_id + '/patients/' + 'search',
    dataType: 'script',
    data: { q: searchSubmission },
    success: function() {
      $('ul.patient_list > li').hide();
      $('li.section_1').show();
      $("ul.link_list > li > a").click(function() {
        $("ul.patient_list > li").hide();
        var patient_list = $(this).attr("patient_num");
        $("li.section_" + patient_list).show();
      });
    }
  });
});




































