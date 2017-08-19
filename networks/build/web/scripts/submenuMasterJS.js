$(document).ready(function () {
    $("#example1").DataTable({
        "bLengthChange": false,
        "bFilter": true,
        "bInfo": false,
        "bAutoWidth": false});
    $("#editSubmenu").click(function () {
        var rd_id = $('input[name=submenuRadio]:checked').val();
        $("#menuCodeField").val($("#" + rd_id + "_menucode").html());
        $("#submenuCodeField").val($("#" + rd_id + "_submenucode").html());
        $("#submenuNameField").val($("#" + rd_id + "_submenuname").html());
        $("#submenuActionPathField").val($("#" + rd_id + "_submenuactionpath").html());
        $("#displayOrder").val($("#" + rd_id + "_submenudisplay").html());
        $("#submenuRemarks").val($("#" + rd_id + "_submenuremark").html());
        // $("#recordStatusField").val($("#" + rd_id + "_submenustatus").html());
    });



    $('.modal').on('hidden.bs.modal', function () {
        $("#editSubmenuForm")[0].reset();
        $("#newSubmenuForm")[0].reset();
    });

    //-------------------------Add Code start---------------------------------------------
    try {

        $("#addSubmenuAction").click(function () {
            if ($('#newMenuNameField').val() == '') {
                $('#newMenuNameError').html("This field is required.");
                return false;
            }

            if ($('#newsubmenuNameField').val() == '') {
                $('#newSubmenuNameError').html("This field is required.");
                return false;
            } else {
                if (!(/^[a-zA-Z ]{3,50}$/.test($("#newsubmenuNameField").val()))) {
                    $('#newSubmenuNameError').html(" Only alphabets Allowed.Minimum length should be 3.");
                    $("#newsubmenuNameField").focus();
                    return false;
                } else {
                    $('#newSubmenuNameError').empty();
                }
            }

            if ($('#newsubmenuActionPathField').val() == '') {
                $('#newSubmenuActionPathError').html("This field is required.");
                return false;
            } else {
                $('#newSubmenuActionPathError').html("");
            }
            if ($('#newdisplayOrder').val() == '') {
                $('#newDisplayError').html("This field is required.");
                return false;
            } else {
                if (!(/^[0-9]{0,6}$/.test($("#newdisplayOrder").val()))) {
                    $('#newDisplayError').html(" Only numeric 0-9  allowed.Maximum length should be 3");
                    $("#newdisplayOrder").focus();
                    return false;
                } else {
                    $('#newDisplayError').empty();
                }
            }
            if ($('#newsubmenuRemarks').val() == '') {
                $('#newsubmenuError').html("This field is required.");
                return false;
            }
            else {
                if (!(/^[a-zA-Z./ ]+$/.test($("#newsubmenuRemarks").val()))) {
                    $('#newsubmenuError').html(" Only alphabets and . Allowed");
                    $("#newsubmenuRemarks").focus();
                    return false;
                } else {
                    $('#newsubmenuError').empty();
                }
            }

            $.ajax({
                type: 'POST',
                url: 'SubmenuMasterServlet',
                // data:  new FormData(this),
                data: $('#newSubmenuForm').serialize(),
                dataType: 'json',
                encode: true,
                success: function (result) {
                    // alert("fgdg"+result.rsval);
                    if (result.rsval == 1) {
                        $('#msgAddSuccess').html("Menu Subcategory successfully Added!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    } else {
                        $('#msgAddError').html("Error In Menu Subcategory Add!");
                    }

                },
                error: function (result)
                {
                    alert("error: In Menu Subcategory Add ");

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

        $("#editSubmenuAction").click(function () {

            if ($('#submenuNameField').val() == '') {
                $('#submenuNameError').html("This field is required.");
                return false;
            } else {
                if (!(/^[a-zA-Z ]{3,50}$/.test($("#submenuNameField").val()))) {
                    $('#submenuNameError').html(" Only alphabets Allowed");
                    $("#submenuNameField").focus();
                    return false;
                } else {
                    $('#submenuNameError').empty();
                }
            }

            if ($('#submenuActionPathField').val() == '') {
                $('#submenuActionPathError').html("This field is required.");
                return false;
            } else {
                $('#submenuActionPathError').empty();

            }

            if ($('#displayOrder').val() == '') {
                $('#displayOrderError').html("This field is required.");
                return false;
            } else {
                if (!(/^[0-9]{0,6}$/.test($("#displayOrder").val()))) {
                    $('#displayOrderError').html(" Only numeric 0-9 and 6 digit allowed ");
                    $("#displayOrder").focus();
                    return false;
                } else {
                    $('#displayOrderError').empty();
                }
            }
            if ($('#submenuRemarks').val() == '') {
                $('#submenuRemarksError').html("This field is required.");
                return false;
            }
            else {
                if (!(/^[a-zA-Z./ ]+$/.test($("#submenuRemarks").val()))) {
                    $('#submenuRemarksError').html(" Only alphabets and . Allowed");
                    $("#submenuRemarks").focus();
                    return false;
                } else {
                    $('#submenuRemarksError').empty();
                }
            }

            $.ajax({
                type: 'POST',
                url: 'SubmenuMasterServlet',
                // data:  new FormData(this),
                data: $('#editSubmenuForm').serialize(),
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.updateStatus == 1) {
                        $('#msgEditSuccess').html("Menu Subcategory successfully Edited!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    } else {
                        $('#msgEditError').html("Error In Menu Subcategory Edit!");
                    }

                },
                error: function (result)
                {
                    alert("error: In Menu Subcategory Edit");

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

            var rd_id = $('input[name=submenuRadio]:checked').val();
            $("#submenuCodeHidden").val($("#" + rd_id + "_submenucode").html());
            var code = $("#submenuCodeHidden").val();

            $.ajax({
                type: "POST",
                url: "SubmenuMasterServlet?hiddenAction=delete&submenuCodeDelete=" + code,
//            contentType: "application/json",
//            async: false, 
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.finalStatus == 2) {

                        $('#msgError1').html("Menu Subcategory already deleted");
                        //$('#msgError1').delay(1000).fadeOut();

                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                    else {

                        $('#msgRight1').html("Menu Subcategory successfully Deleted!");
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

            var rd_id = $('input[name=submenuRadio]:checked').val();
            $("#submenuCodeHidden").val($("#" + rd_id + "_submenucode").html());
            var code = $("#submenuCodeHidden").val();

            $.ajax({
                type: "POST",
                url: "SubmenuMasterServlet?hiddenAction=restore&submenuCodeRestore=" + code,
//            contentType: "application/json",
//            async: false,
                dataType: 'json',
                encode: true,
                success: function (result) {

                    if (result.finalStatusRe == 2) {

                        $('#msgError1').html("Menu Subcategory already Active");
                        // $('#msgError1').delay(1000).fadeOut();
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }
                    else {

                        $('#msgRight1').html("Menu Subcategory successfully Restored!");
                        window.setTimeout(function () {
                            location.reload()
                        }, 1000);
                    }

                    // $('#msgRight1').html("Submenu successfully Restored!");                  
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


