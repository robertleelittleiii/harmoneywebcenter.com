/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// TODO:  Add ajax function to load pictures based on properties object.


$j(document).ready(function(){
    var realtor_id = $j("#realtor-id").text().strip();
    $j.ajax({
        url: "/site/show_prop_slideshow_partial",
        dataType: "html",
        type: "POST",
        data: "realtor_id="+realtor_id ,
        success: function (data)
        {
            //alert(data);
            if (data === undefined || data === null || data === "")
            {
            //display warning
            }
            else
            {
                $j("#create-slide-show").html(data);
                            
                $j('#slideshow').cycle({ 
                    fx:         'scrollLeft', 
                    timeout:     3000, 
                    pager:      '#nav', 
                    pagerEvent: 'mouseover', 
                    fastOnEvent: true 
                });
            }
        }
    });

});

