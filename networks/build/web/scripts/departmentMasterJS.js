  $(document).ready(function () {

                                    $("#example1").DataTable({
                                        "bLengthChange": false,
                                        "bFilter": true,
                                        "bInfo": false,
                                        "bAutoWidth": false});

                                   $("#editDepartment").click(function () {
                                      // alert("dddd");
                                       
                                       var rd_id = $('input[name=departmentRadio]:checked').val();
                                      
                                         $("#ministryCodeField").val($("#" + rd_id + "_ministrycode").html());
                                       $("#departmentCodeField").val($("#" + rd_id + "_departmentcode").html());
                                        $("#departmentNameField").val($("#" + rd_id + "_departmentname").html());
                                       
                                        $("#displayOrder").val($("#" + rd_id + "_departmentdisplay").html());
                                        $("#departmentRemarks").val($("#" + rd_id + "_departmentremark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_departmentstatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editDepartmentForm")[0].reset();
                                        $("#newDepartmentForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addDepartmentAction").click(function () {
                                            if( $('#newMinistryNameField').val()=='')	{                                              
                                    $('#newMinistryNameError').html("This field is required.");
                                            return false; 		
                                            }
                                            
                                        if( $('#newdepartmentNameField').val()=='')	{
                                    $('#newDepartmentNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                if(!(/^[a-zA-Z0-9 ]{3,50}$/.test($("#newdepartmentNameField").val()))){
                                                      $('#newDepartmentNameError').html(" Only alpha numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#newdepartmentNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newDepartmentNameError').empty();                                                   	
                                            }
                                        }
                                            
                                           
                                             if( $('#newdisplayOrder').val()=='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                             if(!(/^[0-9]{0,3}$/.test($("#newdisplayOrder").val()))){
                                                      $('#newDisplayError').html(" Only numeric 0-9  allowed.Maximum length should be 3");                                                  
                                                    $("#newdisplayOrder").focus();
                                                      return false; 
                                                }else{                                                
                                                   $('#newDisplayError').empty();
                                               }	
                                            }
                                             if( $('#newdepartmentRemarks').val()=='')	{
                                    $('#newdepartmentError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newdepartmentRemarks").val()))){
                                                      $('#newdepartmentError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newdepartmentRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newdepartmentError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'DepartmentMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newDepartmentForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("Department successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In Department Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Department Add "); 
                                               
                                            }
                                      });
                                    });
                                    }
                                    catch(e){
                                        alert("EX : "+e);
                                    }
                                  //-----------------------Add Code End---------------------------------------------
                                  
                                    //-------------------------Edit Code start---------------------------------------------
                                   try{
                                        
                                        $("#editDepartmentAction").click(function () {
                                            
                                        if( $('#departmentNameField').val()=='')	{
                                    $('#departmentNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                 if(!(/^[a-zA-Z0-9 ]{3,50}$/.test($("#departmentNameField").val()))){
                                                      $('#departmentNameError').html(" Only alpha numeric Allowed");                                                  
                                                    $("#departmentNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#departmentNameError').empty();                                                   	
                                            }                                                   	
                                            }
                                            
                                           
                                            
                                             if( $('#displayOrder').val()=='')	{
                                    $('#displayOrderError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               if(!(/^[0-9]{0,3}$/.test($("#displayOrder").val()))){
                                                      $('#displayOrderError').html(" Only numeric 0-9 and 3 digit allowed ");                                                  
                                                    $("#displayOrder").focus();
                                                      return false; 
                                                }else{                                                
                                                   $('#displayOrderError').empty();
                                               }
                                            }
                                             if( $('#departmentRemarks').val()=='')	{
                                    $('#departmentRemarksError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                             if(!(/^[a-zA-Z./ ]+$/.test($("#departmentRemarks").val()))){
                                                      $('#departmentRemarksError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#departmentRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#departmentRemarksError').empty();                                                   	
                                            }    
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'DepartmentMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#editDepartmentForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                            
                                                if(result.updateStatus==1){
                                                    $('#msgEditSuccess').html("Department successfully Edited!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgEditError').html("Error In Department Edit!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Department Edit"); 
                                               
                                            }
                                      });
                                    });
                                    }
                                    catch(e){
                                        alert("EX : "+e);
                                    }
                                  //-----------------------Edit Code End---------------------------------------------
                             
           //----deactivation code------------------------ 
           
    $("#delete").click(function () {       
         var r = confirm("Are u sure to delete then press ok otherwise cancel");
        if (r == true) {
    
          var rd_id = $('input[name=departmentRadio]:checked').val();
               $("#departmentCodeHidden").val($("#" + rd_id + "_departmentcode").html());
               var code=$("#departmentCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "DepartmentMasterServlet?hiddenAction=delete&departmentCodeDelete="+code,       
//            contentType: "application/json",
//            async: false, 
                    dataType: 'json',
                     encode: true,
            success: function (result) { 
               
                  if(result.finalStatus==2){
                    
                          $('#msgError1').html("Department already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("Department successfully Deleted!");                
                   window.setTimeout(function(){location.reload()},1000);
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
    
          var rd_id = $('input[name=departmentRadio]:checked').val();
               $("#departmentCodeHidden").val($("#" + rd_id + "_departmentcode").html());
               var code=$("#departmentCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "DepartmentMasterServlet?hiddenAction=restore&departmentCodeRestore="+code,
//            contentType: "application/json",
//            async: false,
             dataType: 'json',
                     encode: true,
            success: function (result) {               
                
                  if(result.finalStatusRe==2){
                   
                          $('#msgError1').html("Department already Active");
                         // $('#msgError1').delay(1000).fadeOut();
                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("Department successfully Restored!");                
                   window.setTimeout(function(){location.reload()},1000);
                         }
                
                  // $('#msgRight1').html("Department successfully Restored!");                  
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


