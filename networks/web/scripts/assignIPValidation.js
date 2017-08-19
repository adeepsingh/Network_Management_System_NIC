$().ready(function() {
    $("[data-mask]").inputmask();
    $("#assignIPAddress").validate({
        rules: {
            name: {
                required: true,                
                minlength: 3
            },
            locationCode: {
                required: true                
            },
            ministryCode: {
                required: true
            },
            departmentCode: {
                required: true
            },
            floorCode: {
                required: true
            },
            designationCode: {
                required: true
            },
            empCode: {
                required: true,
                minlength: 3
            },
            contactNo: {
                required: true,
                minlength: 3
            },
            InterComm: {
                required: true                
            },
            email: {
                required: true,
                email: true
            },
            employeeTypeCode: {
                required: true
            },
            macAddress: {
                required: true,
                maxlength: 17,
                minlength: 17
            },
            sectionCode: "required",
            remarks: "required",
            deviceTypeCode: "required",
            assessLevelCode: "required",
            activationDate: "required",
            deactivationDate: "required"
        },
        messages: {
            name: {
                required: "Please Enter Name",
                minlength: "Minimum Length 3 Required."
            },
            locationCode: {
                required: "Please Select Location."
            },
            ministryCode: "Please Select Ministry.",
            departmentCode: "Please Select Department.",
            sectionCode: "Please Select Section.",
            floorCode: "Please Select Floor.",
            designationCode: "Please Select Designation.",
            empCode: "Please Enter Employee Code.",
            contactNo: "Please Enter Contact Number.",
            InterComm:  {
                required: "Please Enter Inter-Comm"                
            },
            email: "Please Enter Email ID.",
            employeeTypeCode: "Please Select Employment Type.",
            macAddress: {
                required: "Please Enter Mac-Address",
                maxlength: "Please Enter Correct Mac-Address, 17 Characters",
                minlength: "Please Enter Correct Mac-Address, 17 Characters"
            },
            remarks: "Please Enter Remarks?",
            deviceTypeCode: "Please Select Device Type.",
            assessLevelCode: "Please Select Access Level.",
            activationDate: "Please Enter Activation Date.",
            deactivationDate: "Please Enter Deactivation Date."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});