/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// TODO:  Add ajax function to load pictures based on properties object.


$j(document).ready(function(){

    $j('#slideshow').cycle({ 
        fx:         'scrollLeft', 
        timeout:     3000, 
        pager:      '#nav', 
        pagerEvent: 'mouseover', 
        fastOnEvent: true 
    });
});

