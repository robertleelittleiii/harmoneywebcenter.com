/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$j(document).ready(function(){

    $j('#slideshow').cycle({ 
        fx:         'scrollLeft', 
        timeout:     3000, 
        pager:      '#nav', 
        pagerEvent: 'mouseover', 
        fastOnEvent: true 
    });
});

