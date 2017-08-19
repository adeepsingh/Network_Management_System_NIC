$(document).ready(function () {
    $("#example1").DataTable({
        "bLengthChange": false,
        "bFilter": true,
        "bInfo": false,
        "bAutoWidth": false});

    $("#editSection").click(function () {
        var rd_id = $('input[name=sectionRadio]:checked').val();
        $("#departmentCodeField").val($("#" + rd_id + "_departmentcode").html());
        $("#sectionCodeField").val($("#" + rd_id + "_sectioncode").html());
        $("#sectionNameField").val($("#" + rd_id + "_sectionname").html());
        $("#displayOrder").val($("#" + rd_id + "_sectiondisplay").html());
        $("#sectionRemarks").val($("#" + rd_id + "_sectionremark").html());
    });

    $('.modal').on('hidden.bs.modal', function () {
        $("#editSectionForm")[0].reset();
        $("#newSectionForm")[0].reset();
    });

    //-------------------------Add Code start---------------------------------------------
    try {
        $("#addSectionAction").click(function () {
            if ($('#newDepartmentNameField').val() == '') {
                $('#newDepartmentNameError').html("This field is required.");
                return false;
            }

            if ($('#newsectionNameField').val() == '') {
                $('#newSectionNameError').html("This field is required.");
                return false;
            } else {
                if (!(/^[a-zA-Z0-9 ]{3,50}$/.test($("#newsectionNameField").val()))) {
                    $('#newSectionNameError').html(" Only alpha numeric Allowed.Minimum length should be 3.");
                    $("#newsectionNameField").focus();
                    return false;
                } else {
                    $('#newSectionNameError').empty();
                }
            }


            if ($('#newdisplayOrder').val() == '') {
                $('#newDisplayError').html("This field is required.");
                return false;
            } else {
                if (!(/^[0-9]{0,4}$/.test($("#newdisplayOrder").val()))) {
                    $('#newDisplayError').html(" Only numeric 0-9  allowed.Maximum length should be 4");
                    $("#newdisplayOrder").focus();
                    return false;
                } else {
                    $('#newDisplayError').empty();
                }
            }
            if ($('#newsectionRemarks').val() == '') {
                $('#newsectionError').html("This field is required.");
                return false;
            }
            else {
                if (!(/^[a-zA-Z./ ]+$/.test($("#newsectionRemarks").val()))) {
                    $('#newsectionError').html(" Only alphabets and . Allowed");
                    $("#newsectionRemarks").focus();
                    return false;
                } else {
                    $('#newsectionError').empty();
                }
            }

            $.ajax({
                type: 'POST',
                url: 'SectionMasterServlet',
                // data:  new FormData(this),
                data: $('#newSectionForm').serialize(),
                dataType: 'json',
                encode: true,
                success: function (result) {
                    // alert("fgdg"+result.rsval);
                    if (result.rsval == 1) {
                        $('#msgAddSuccess').html("Section successfully Added!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    } else {
                        $('#msgAddError').html("Error In Section Add!");
                    }

                },
                error: function (result)
                {
                    alert("error: In Section Add ");

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

        $("#editSectionAction").click(function () {

            if ($('#sectionNameField').val() == '') {
                $('#sectionNameError').html("This field is required.");
                return false;
            } else {
                if (!(/^[a-zA-Z0-9 ]{3,50}$/.test($("#sectionNameField").val()))) {
                    $('#sectionNameError').html(" Only alpha numeric Allowed");
                    $("#sectionNameField").focus();
                    return false;
                } else {
                    $('#sectionNameError').empty();
                }
            }



            if ($('#displayOrder').val() == '') {
                $('#displayOrderError').html("This field is required.");
                return false;
            } else {
                if (!(/^[0-9]{0,4}$/.test($("#displayOrder").val()))) {
                    $('#displayOrderError').html(" Only numeric 0-9 and 4 digit allowed ");
                    $("#displayOrder").focus();
                    return false;
                } else {
                    $('#displayOrderError').empty();
                }
            }
            if ($('#sectionRemarks').val() == '') {
                $('#sectionRemarksError').html("This field is required.");
                return false;
            }
            else {
                if (!(/^[a-zA-Z./ ]+$/.test($("#sectionRemarks").val()))) {
                    $('#sectionRemarksError').html(" Only alphabets and . Allowed");
                    $("#sectionRemarks").focus();
                    return false;
                } else {
                    $('#sectionRemarksError').empty();
                }
            }

            $.ajax({
                type: 'POST',
                url: 'SectionMasterServlet',
                // data:  new FormData(this),
                data: $('#editSectionForm').serialize(),
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.updateStatus == 1) {
                        $('#msgEditSuccess').html("Section successfully Edited!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    } else {
                        $('#msgEditError').html("Error In Section Edit!");
                    }

                },
                error: function (result)
                {
                    alert("error: In Section Edit");

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

            var rd_id = $('input[name=sectionRadio]:checked').val();
            $("#sectionCodeHidden").val($("#" + rd_id + "_sectioncode").html());
            var code = $("#sectionCodeHidden").val();

            $.ajax({
                type: "POST",
                url: "SectionMasterServlet?hiddenAction=delete&sectionCodeDelete=" + code,
//            contentType: "application/json",
//            async: false, 
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.finalStatus == 2) {

                        $('#msgError1').html("Section already deleted");
                        //$('#msgError1').delay(1000).fadeOut();

                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                    else {

                        $('#msgRight1').html("Section successfully Deleted!");
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

            var rd_id = $('input[name=sectionRadio]:checked').val();
            $("#sectionCodeHidden").val($("#" + rd_id + "_sectioncode").html());
            var code = $("#sectionCodeHidden").val();

            $.ajax({
                type: "POST",
                url: "SectionMasterServlet?hiddenAction=restore&sectionCodeRestore=" + code,
//            contentType: "application/json",
//            async: false,
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.finalStatusRe == 2) {

                        $('#msgError1').html("Section already Active");
                        // $('#msgError1').delay(1000).fadeOut();
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                    else {

                        $('#msgRight1').html("Section successfully Restored!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }

                    // $('#msgRight1').html("Section successfully Restored!");                  
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


