$().ready(function () {

    $("[data-mask]").inputmask();
    $("#court_address_pin").inputmask({"mask": "9", "repeat": 6, "greedy": true});
    $('#issue_date').datepicker({
        format: 'dd/mm/yyyy',
        todayHighlight: true,
        todayBtn: 'linked',
        autoclose: true

    }).on('change', function () {
        $('#issue_date').valid();  // triggers the validation test on change
    });

    $('#court_issue_date').datepicker({
        format: 'dd/mm/yyyy',
        todayHighlight: true,
        todayBtn: 'linked',
        autoclose: true

    }).on('change', function () {
        $('#court_issue_date').valid();  // triggers the validation test on change
    });

    $('#recv_date_court').datepicker({
        format: 'dd/mm/yyyy',
        todayHighlight: true,
        todayBtn: 'linked',
        autoclose: true

    }).on('change', function () {
        $('#recv_date_court').valid();  // triggers the validation test on change
    });

    $('#accuse_nextdate').datepicker({
        format: 'dd/mm/yyyy',
        todayHighlight: true,
        todayBtn: 'linked',
        autoclose: true,
        minDate: 0

    }).on('change', function () {
        $('#accuse_nextdate').valid();  // triggers the validation test on change
    });
    $('#edit_accuse_nextdate').datepicker({
        format: 'dd/mm/yyyy',
        todayHighlight: true,
        todayBtn: 'linked',
        autoclose: true

    }).on('change', function () {
        $('#accuse_nextdate').valid();  // triggers the validation test on change
    });


    $("#addAccuseButton").click(function () {

        $("#addAccuseModal").modal("hide");
        var temp_count = (parseInt($("#temp_count").val()) + 1);
        var display_count = (parseInt($("#display_count").html()) + 1);
        $("#display_count").html(display_count);
        $("#temp_count").val(temp_count);
        var accuse_case_no = $("#accuse_case_no").val();
        var accuse_name = $("#accuse_name").val();
        var accuse_address = $("#accuse_address").val();
        var accuse_nextdate_hearing = $("#accuse_nextdate").val();
        var accuse_passport_no = $("#accuse_passport_no").val();
        var accuse_fname = $("#accuse_fname").val();
        var phone_fax_mobile = $("#phone_fax_mobile").val();
        var accuse_case_title = $("#accuse_case_title").val();
        $("#accusedetailsform").find("input[type=text], textarea").val("");

        var html = '<div class="col-md-12 accuse_div_class" id="accuse_' + temp_count + '_div">' +
                '<div class="col-md-1"><input type="hidden" name="accuse_nameA" id="accuse_name_0" value="'+accuse_name+'"/><span class="accuse_name" id="accuse_name_' + temp_count + '">' + accuse_name + '</span></div>' +
                '<div class="col-md-1"><input type="hidden" name="accuse_fnameA" value="'+accuse_fname+'"/><span class="accuse_father" id="accuse_father_' + temp_count + '">' + accuse_fname + '</span></div>' +
                '<div class="col-md-2"><input type="hidden" name="accuse_addressA" value="'+accuse_address+'"/><span class="accuse_address" id="accuse_address_' + temp_count + '">' + accuse_address + '</span></div>' +
                '<div class="col-md-1"><input type="hidden" name="accuse_case_noA" value="'+accuse_case_no+'"/><span class="accuse_case_no" id="accuse_case_no_' + temp_count + '">' + accuse_case_no + '</span></div>' +
                '<div class="col-md-2"><input type="hidden" name="accuse_case_titleA" value="'+accuse_case_title+'"/><span class="accuse_case_title" id="accuse_case_title_' + temp_count + '">' + accuse_case_title + '</span></div>' +
                '<div class="col-md-1"><input type="hidden" name="accuse_nextdate_hearingA" value="'+accuse_nextdate_hearing+'"/><span class="accuse_date_hearing" id="accuse_date_hearing_' + temp_count + '">' + accuse_nextdate_hearing + '</span></div>' +
                '<div class="col-md-2"><input type="hidden" name="accuse_passport_noA" value="'+accuse_passport_no+'"/><span class="accuse_passport_no" id="accuse_passport_no_' + temp_count + '">' + accuse_passport_no + '</span></div>' +
                '<div class="col-md-1"><input type="hidden" name="phone_fax_mobileA" value="'+phone_fax_mobile+'"/><span class="accuse_phone" id="accuse_phone_' + temp_count + '">' + phone_fax_mobile + '</span></div>' +
                '<div class="col-md-1"><span class="pull-right"><a href="#" class="edit_accuse" id="' + temp_count + '">Edit</a>/ <a href="#" class="accuse_delete_link" id="' + temp_count + '_div">Delete</a></span></div>'
                + '</div>';

        $("#accuse_display_table").append(html);

        return false;
    });

    $("#updateAccuseButton").click(function () {

        $("#editAccuseModal").modal("hide");
        var temp_count = $("#temp_id").val();
        var accuse_case_no = $("#edit_accuse_case_no").val();
        var accuse_name = $("#edit_accuse_name").val();
        var accuse_address = $("#edit_accuse_address").val();
        var accuse_nextdate_hearing = $("#edit_accuse_nextdate").val();
        var accuse_passport_no = $("#edit_accuse_passport_no").val();
        var accuse_fname = $("#edit_accuse_fname").val();
        var phone_fax_mobile = $("#edit_phone_fax_mobile").val();
        var accuse_case_title = $("#edit_accuse_case_title").val();
        $("#editaccusedetailsform").find("input[type=text], textarea").val("");

        $("#accuse_name_" + temp_count).html(accuse_name);
        $("#accuse_father_" + temp_count).html(accuse_fname);
        $("#accuse_address_" + temp_count).html(accuse_address);
        $("#accuse_case_no_" + temp_count).html(accuse_case_no);
        $("#accuse_case_title_" + temp_count).html(accuse_case_title);
        $("#accuse_date_hearing_" + temp_count).html(accuse_nextdate_hearing);
        $("#accuse_passport_no_" + temp_count).html(accuse_passport_no);
        $("#accuse_phone_" + temp_count).html(phone_fax_mobile);

        return false;
    });


    $(document).on("click", ".accuse_delete_link", function () {
        var id = "accuse_" + $(this).attr("id");
        var display_count = (parseInt($("#display_count").html()) - 1);
        $("#display_count").html(display_count);
        $("#" + id).remove();
        return false;
    });

    $(document).on("click", ".edit_accuse", function () {
        var temp_count = $(this).attr("id")
        $("#edit_accuse_name").val($("#accuse_name_" + temp_count).html());
        $("#edit_accuse_fname").val($("#accuse_father_" + temp_count).html());
        $("#edit_accuse_address").val($("#accuse_address_" + temp_count).html());
        $("#edit_accuse_case_no").val($("#accuse_case_no_" + temp_count).html());
        $("#edit_accuse_case_title").val($("#accuse_case_title_" + temp_count).html());
        $("#edit_accuse_nextdate").val($("#accuse_date_hearing_" + temp_count).html());
        $("#edit_accuse_passport_no").val($("#accuse_passport_no_" + temp_count).html());
        $("#edit_phone_fax_mobile").val($("#accuse_phone_" + temp_count).html());
        $("#temp_id").val(temp_count);
        $("#editAccuseModal").modal("show");
        return false;
    });


$('#send_country').change(function (event) {
        var countryCode = $("select#send_country").val();
        $.get('getEmbassyList', {
            //sportsName: sports
            countryCode: countryCode
        }, function (response) {
            $('#send_name').removeAttr('disabled');
            var select = $('#send_name');
            select.find('option').remove();
            $.each(response, function (index, value) {
                $('<option>').val(index).text(value).appendTo(select);
            });
        });
    });
    
   /* $("#send_country").change(function () {

        $("#send_name").attr("disabled", "disabled");

        $("#send_address").attr("readonly", "true");

        $("#send_name").val("");

        $("#send_address").val("");


        var country = $("#send_country").val();


        $.ajax
                (
                        {
                            url: "listEmbassyNameByCountry?countryCode=" + country,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader("Accept", "application/json");
                                xhr.setRequestHeader("Content-Type", "application/json");
                                xhr.setRequestHeader('X-CSRF-Token', $('#secureToken').val());
                            }
                            ,
                            type: 'POST'
                            ,
                            success: function (data)
                            {
                                if (data.status == 'FAIL')
                                {
                                    alert("No embassy listed for selected country.\n Contact Administrator.");
                                }
                                else
                                {
                                    var html = '<option value="" selected>----Select Embassy/Mission Name----</option>';
                                    var len = data.result.length;
                                    for (var i = 0; i < len; i++)
                                    {
                                        html += '<option value="' + data.result[i].embassy_name + '">'
                                                + data.result[i].embassy_name
                                                + '</option>';
                                    }
                                    $('#send_name').html(html);
                                    $('#send_name').removeAttr('disabled');

                                }

                            }});

    }); */


$('#send_name').change(function (event) {
        var countryCode = $("select#send_country").val();
        var nameCode = $("select#send_name").val();
        $.get('getEmbassyAddressList', {
             countryCode: countryCode,nameCode: nameCode
         }, function (response) {
             $('#send_address').removeAttr('disabled');
            var select = $('#send_address');
            select.find('option').remove();
            $.each(response, function (index, value) {
                $('<option>').val(index).text(value).appendTo(select);
            });
        });
    });

  /*  $("#send_name").change(function () {



        $("#send_address").attr("readonly", "true");


        $("#send_address").val("");


        var country = $("#send_country").val();
        var embassy_name = $("#send_name").val();


        $.ajax
                (
                        {
                            url: "getEmbassyAddressByCountryAndEmbassy?countryCode=" + country + "&embassyName=" + embassy_name,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader("Accept", "application/json");
                                xhr.setRequestHeader("Content-Type", "application/json");
                                xhr.setRequestHeader('X-CSRF-Token', $('#secureToken').val());
                            }
                            ,
                            type: 'POST'
                            ,
                            success: function (data)
                            {
                                if (data.status == 'FAIL')
                                {
                                    alert("No embassy address listed for selected embassy.\n Contact Administrator.");
                                }
                                else
                                {
                                    $('#send_address').val(data.result);
                                }


                            }});

    }); */



    $("#central_authority").change(function () {


        var centralAuthority = $("#central_authority").val();


        $.ajax
                (
                        {
                            url: "getCentralAuthorityAddressByCentralAuthorityCode?centralAuthority=" + centralAuthority,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader("Accept", "application/json");
                                xhr.setRequestHeader("Content-Type", "application/json");
                                xhr.setRequestHeader('X-CSRF-Token', $('#secureToken').val());
                            }
                            ,
                            type: 'POST'
                            ,
                            success: function (data)
                            {
                                if (data.status == 'FAIL')
                                {
                                    alert("No central authority address listed for selected central authority.\n Contact Administrator.");
                                }
                                else
                                {
                                    $('#central_authority_address').val(data.result);
                                }


                            }});

    });


    $('#court_address_state').change(function (event) {
        var stateCode = $("select#court_address_state").val();
        $.get('listDistrictByState', {
            //sportsName: sports
            stateCode: stateCode
        }, function (response) {
            $('#court_address_dist').removeAttr('disabled');
            var select = $('#court_address_dist');
            select.find('option').remove();
            $.each(response, function (index, value) {
                $('<option>').val(index).text(value).appendTo(select);
            });
        });
    });


    /* $("#court_address_state").change(function(){
     
     $("#court_address_dist").attr("disabled", "disabled");
     
     $("#court_address_dist").val("");
     
     var state=$("#court_address_state").val();
     alert("court_address_state::"+state);
     $.ajax
     (
     {
     url: "listDistrictByState?stateCode="+state,
     beforeSend : function(xhr) {
     xhr.setRequestHeader("Accept", "application/json");
     xhr.setRequestHeader("Content-Type", "application/json");
     xhr.setRequestHeader('X-CSRF-Token', $('#secureToken').val());
     }
     ,
     type: 'POST'
     ,
     success: function(data) 
     {
     if(data.status=='FAIL')
     {
     alert("No district listed for selected state.\n Contact Administrator.");
     }
     else
     {
     var html = '<option value="" selected>----Select Court District----</option>';
     var len = data.result.length;
     alert("data.result.length::"+data.result.length);	
     for (var i = 0; i < len; i++) 
     {
     html += '<option value="' + data.result[i].dist_name + '">'
     + data.result[i].dist_name
     + '</option>';
     }
     $('#court_address_dist').html(html);
     $('#court_address_dist').removeAttr('disabled');
     
     }
     
     }});
     
     });  */

    $("#generateLetterSubmit").click(function () {
        var count = $("#display_count").html();
        var html = "";
        for (var i = 0; i < count; i++)
        {
            var accuse_count = (parseInt(i) + 1);
            html += '<input type="hidden" name="accuselist[' + i + '].accuse_name" value="' + $("#accuse_name_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].accuse_fname" value="' + $("#accuse_fname_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].accuse_address" value="' + $("#accuse_address_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].accuse_case_no" value="' + $("#accuse_case_no_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].accuse_case_title" value="' + $("#accuse_case_title_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].accuse_nextdate_hearing" value="' + $("#accuse_nextdate_hearing_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].accuse_passport_no" value="' + $("#accuse_passport_no_" + accuse_count).html() + '">' +
                    '<input type="hidden" name="accuselist[' + i + '].phone_fax_mobile" value="' + $("#accuse_phone_" + accuse_count).html() + '">'

        }
        $("#accuse_form_list").html(html);
        $("#letterdetailsform").attr("action", "letterIssueSave");
        $("#letterdetailsform").attr("method", "post");
        $("#letterdetailsform").submit();

        return false;
    });

});
