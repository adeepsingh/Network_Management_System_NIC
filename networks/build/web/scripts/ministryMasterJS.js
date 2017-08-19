$(document).ready(function () {

    $("#example1").DataTable({
        "bLengthChange": false,
        "bFilter": true,
        "bInfo": false,
        "bAutoWidth": false});

    $("#editMinistry").click(function () {
        // alert("dddd");

        var rd_id = $('input[name=ministryRadio]:checked').val();

        $("#locationCodeField").val($("#" + rd_id + "_locationcode").html());
        $("#ministryCodeField").val($("#" + rd_id + "_ministrycode").html());
        $("#ministryNameField").val($("#" + rd_id + "_ministryname").html());

        $("#displayOrder").val($("#" + rd_id + "_ministrydisplay").html());
        $("#ministryRemarks").val($("#" + rd_id + "_ministryremark").html());
        // $("#recordStatusField").val($("#" + rd_id + "_ministrystatus").html());
    });



    $('.modal').on('hidden.bs.modal', function () {
        $("#editMinistryForm")[0].reset();
        $("#newMinistryForm")[0].reset();
    });

    //-------------------------Add Code start---------------------------------------------
    try {

        $("#addMinistryAction").click(function () {
            if ($('#newLocationNameField').val() == '') {
                $('#newLocationNameError').html("This field is required.");
                return false;
            }

            if ($('#newministryNameField').val() == '') {
                $('#newMinistryNameError').html("This field is required.");
                return false;
            } else {
                if (!(/^[a-zA-Z0-9 ]{3,50}$/.test($("#newministryNameField").val()))) {
                    $('#newMinistryNameError').html(" Only alpha numeric Allowed.Minimum length should be 3.");
                    $("#newministryNameField").focus();
                    return false;
                } else {
                    $('#newMinistryNameError').empty();
                }
            }


            if ($('#newdisplayOrder').val() == '') {
                $('#newDisplayError').html("This field is required.");
                return false;
            } else {
                if (!(/^[0-9]{0,2}$/.test($("#newdisplayOrder").val()))) {
                    $('#newDisplayError').html(" Only numeric 0-9  allowed.Maximum length should be 2");
                    $("#newdisplayOrder").focus();
                    return false;
                } else {
                    $('#newDisplayError').empty();
                }
            }
            if ($('#newministryRemarks').val() == '') {
                $('#newministryError').html("This field is required.");
                return false;
            }
            else {
                if (!(/^[a-zA-Z./ ]+$/.test($("#newministryRemarks").val()))) {
                    $('#newministryError').html(" Only alphabets and . Allowed");
                    $("#newministryRemarks").focus();
                    return false;
                } else {
                    $('#newministryError').empty();
                }
            }

            $.ajax({
                type: 'POST',
                url: 'MinistryMasterServlet',
                // data:  new FormData(this),
                data: $('#newMinistryForm').serialize(),
                dataType: 'json',
                encode: true,
                success: function (result) {
                    // alert("fgdg"+result.rsval);
                    if (result.rsval == 1) {
                        $('#msgAddSuccess').html("Ministry successfully Added!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    } else {
                        $('#msgAddError').html("Error In Ministry Add!");
                    }

                },
                error: function (result)
                {
                    alert("error: In Ministry Add ");

                }
            });
        });
    }
    catch (e) {
        alert("EX : " + e);
    }
    //-----------------------Add Code End---------------------------------------------

    //-------------------------Edit Code start---------------------------------------------
    try {

        $("#editMinistryAction").click(function () {

            if ($('#ministryNameField').val() == '') {
                $('#ministryNameError').html("This field is required.");
                return false;
            } else {
                if (!(/^[a-zA-Z0-9 ]{3,50}$/.test($("#ministryNameField").val()))) {
                    $('#ministryNameError').html(" Only alpha numeric Allowed");
                    $("#ministryNameField").focus();
                    return false;
                } else {
                    $('#ministryNameError').empty();
                }
            }



            if ($('#displayOrder').val() == '') {
                $('#displayOrderError').html("This field is required.");
                return false;
            } else {
                if (!(/^[0-9]{0,2}$/.test($("#displayOrder").val()))) {
                    $('#displayOrderError').html(" Only numeric 0-9 and 2 digit allowed ");
                    $("#displayOrder").focus();
                    return false;
                } else {
                    $('#displayOrderError').empty();
                }
            }
            if ($('#ministryRemarks').val() == '') {
                $('#ministryRemarksError').html("This field is required.");
                return false;
            }
            else {
                if (!(/^[a-zA-Z./ ]+$/.test($("#ministryRemarks").val()))) {
                    $('#ministryRemarksError').html(" Only alphabets and . Allowed");
                    $("#ministryRemarks").focus();
                    return false;
                } else {
                    $('#ministryRemarksError').empty();
                }
            }

            $.ajax({
                type: 'POST',
                url: 'MinistryMasterServlet',
                // data:  new FormData(this),
                data: $('#editMinistryForm').serialize(),
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.updateStatus == 1) {
                        $('#msgEditSuccess').html("Ministry successfully Edited!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    } else {
                        $('#msgEditError').html("Error In Ministry Edit!");
                    }

                },
                error: function (result)
                {
                    alert("error: In Ministry Edit");

                }
            });
        });
    }
    catch (e) {
        alert("EX : " + e);
    }
    //-----------------------Edit Code End---------------------------------------------

    //----deactivation code------------------------ 

    $("#delete").click(function () {
        var r = confirm("Are u sure to delete then press ok otherwise cancel");
        if (r == true) {

            var rd_id = $('input[name=ministryRadio]:checked').val();
            $("#ministryCodeHidden").val($("#" + rd_id + "_ministrycode").html());
            var code = $("#ministryCodeHidden").val();

            $.ajax({
                type: "POST",
                url: "MinistryMasterServlet?hiddenAction=delete&ministryCodeDelete=" + code,
//            contentType: "application/json",
//            async: false, 
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.finalStatus == 2) {

                        $('#msgError1').html("Ministry already deleted");
                        //$('#msgError1').delay(1000).fadeOut();

                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                    else {

                        $('#msgRight1').html("Ministry successfully Deleted!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                }
            });
        } else {
        }
    });
    //-------------------------activation code------------------------ 

    $("#restore").click(function () {
        var r = confirm("Are You sure to restore then press ok otherwise cancel");
        if (r == true) {

            var rd_id = $('input[name=ministryRadio]:checked').val();
            $("#ministryCodeHidden").val($("#" + rd_id + "_ministrycode").html());
            var code = $("#ministryCodeHidden").val();

            $.ajax({
                type: "POST",
                url: "MinistryMasterServlet?hiddenAction=restore&ministryCodeRestore=" + code,
//            contentType: "application/json",
//            async: false,
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.finalStatusRe == 2) {

                        $('#msgError1').html("Ministry already Active");
                        // $('#msgError1').delay(1000).fadeOut();
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                    else {

                        $('#msgRight1').html("Ministry successfully Restored!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }

                    // $('#msgRight1').html("Ministry successfully Restored!");                  
                    //window.setTimeout(function(){location.reload()},1000);


                }
            });
        } else {
        }
    });

});




/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


