/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$j(document).ready(function(){

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
})


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
