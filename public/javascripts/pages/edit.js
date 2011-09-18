/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$j(document).ready(function(){

 $j('#page_body_save').bind("click", function() {
        alert("clicked");
        $j(this).closest("form").trigger("submit");
        return true;
    });
    
});

function ajaxSave()
{
    
            tinyMCE.triggerSave();

            $j("#page_body_save").closest("form").trigger("submit");

}