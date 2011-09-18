/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$j(document).ready(function(){
     var toggleLoading = function() {$j("#loader_progress").toggle()};


//
//
// image class bindings
// 

    $j('input#image').bind("change", function() {
 //       alert("changed");
        $j(this).closest("form").trigger("submit");
    });
    
//
// delete image bindings
//
//
//    $j('.delete_image').bind('ajax:before', function(){
//        //     window.alert("before");
//             toggleLoading();
//    }) 
//    .bind('ajax:complete', function(){
//         //     window.alert("after");
//
//            toggleLoading();
//    })
//    .bind('ajax:success', function() {  
// //           window.alert("test");
//             $j(this).closest('.imageSingle').fadeOut();
//             if ($j(".imageSingle").length < 9) then
//                 {
//                     $j("div#imagebutton").fadeIn();
//
//                 };
//        });  
 //
 // upload form bindings
 //
 //
    $j('.upload-form').bind('ajax:before', function(){
             window.alert("before");
// toggleLoading();
    }) 
    .bind('ajax:complete', function(){
              window.alert("after");

  //      toggleLoading();
    })
    .bind('ajax:success', function(event, data, status, xhr) {
      //$("#response").html(data);
      window.alert("success");
    });
    
    //
 // upload form bindings
 //
 //
    $j('.test-form').bind('ajax:before', function(){
             window.alert("before");
// toggleLoading();
    }) 
    .bind('ajax:complete', function(){
              window.alert("after");

  //      toggleLoading();
    })
    .bind('ajax:success', function(event, data, status, xhr) {
      //$("#response").html(data);
      window.alert("success");
    })
    .bind('xhr.upload.onloadstart', function(event, data, status, xhr) {
      //$("#response").html(data);
      window.alert("success");
    })
    .bind('xhr.upload.onload', function(event, data, status, xhr) {
      //$("#response").html(data);
      window.alert("success");
    })
    .bind('xhr.upload.onerror', function(event, data, status, xhr) {
      //$("#response").html(data);
      window.alert("success");
    })
    .bind('xhr.upload.onabort', function(event, data, status, xhr) {
      //$("#response").html(data);
      window.alert("success");
    });
    
    
    $j("#menu_m_type").bind("change", function() {
        selected_item= $j("#menu_m_type option:selected");
        //alert(this.getAttribute("data-id"));


             $j.ajax({
                        url: "/menus/ajax_load_partial",
                        dataType: "html",
                        type: "POST",
                        data: "id="+this.getAttribute("data-id")+ "&partial_type="+selected_item.text() ,
                        success: function (data)
                        {
                            //alert(data);
                            if (data === undefined || data === null || data === "")
                            {
                                //display warning
                            }
                            else
                            {
                                $j("#menu-options").html(data);
                                $j(".best_in_place").best_in_place();

                            }
                        }
                    });
     

 /*       switch (selected_item.attr("value"))
        {
          case "1":
               {

   /*                   $j('#menu-options').replaceWith($j.ajax({
                        url: "/menus/ajax_load_partial",
                        dataType: "html",
                        type: "POST",
                        data: "partial_type="+selected_item.text() }));
*/
                    //alert(selected_item.text());

     /*               $j.ajax({
                        url: "/menus/ajax_load_partial",
                        dataType: "html",
                        type: "POST",
                        data: "partial_type="+selected_item.text() ,
                        success: function (data)
                        {
                            //alert(data);
                            if (data === undefined || data === null || data === "")
                            {
                                //display warning
                            }
                            else
                            {
                                $j("#menu-options").html(data);
                            }
                        }
                    });
break;
                }
                    
            /*        $j('#menu-options').replaceWith($j.ajax({
                        url: "/menus/ajax_load_partial",
                        dataType: "html",
                        type: "POST",
                        data: "partial_type="+selected_item.text() }));
*/
   /*

            case "2":
            {
                alert("html");
                break;
            }
            case "3":
            {
                alert("stuff");
                break;
            }
            default:
            {
                alert("unknown");
                break;
            }
        };

*/
    });
    
   
});




/*  $("#spinner").show(); // show the spinner
  var form = $(this).parents("form"); // grab the form wrapping the search bar.
  var url = form.attr("action"); // grab the URL from the form's action value.
  var formData = form.serialize(); // grab the data in the form
  $.get(url, formData, function(html) { // perform an AJAX get, the trailing function is what happens on successful get.
    $("#spinner").hide(); // hide the spinner
    $("#results").html(html); // replace the "results" div with the result of action taken


 switch (red) {
case 1: result = 'one'; break;
case 2: result = 'two'; break;
default: result = 'unknown';
}
docum
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 * */
