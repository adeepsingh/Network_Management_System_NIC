$().ready(function() {
    $("[data-mask]").inputmask();
    $("#allocateddeviceUIForm").validate({
        rules: {
            name: {
                required: true,
                minlength: 3
            },
            locationCode: "required",
            ministryCode: {
                required: true,
                minlength: 2
            },
            departmentCode: "required",
            floorCode: "required",
            designationCode: "required",
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
            employeeTypeCode: "required",
            macAddress: {
                required: true
            },
            deviceTypeCode: "required",
            accessLevel: "required",
            activationDate: "required",
            deactivationDate: "required"
        },
        messages: {
            name: "Name is required.",
            locationCode: "Please Select Location.",
            ministryCode: "Please Select Ministry.",
            departmentCode: "Please Select Department.",
            floorCode: "Please Select Floor.",
            designationCode: "Please Select Designation.",
            empCode: "Please Enter Employee Code.",
            contactNo: "Please Enter Contact Number.",
            InterComm: "Please Enter Inter-Com",
            email: "Please Enter Email ID.",
            employeeTypeCode: "Please Select Employment Type.",
            macAddress: "Please Enter Mac-Address",
            deviceTypeCode: "Please Select Device Type.",
            accessLevel: "Please Select Access Level.",
            activationDate: "Please Enter Activation Date.",
            deactivationDate: "Please Enter Deactivation Date."
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});