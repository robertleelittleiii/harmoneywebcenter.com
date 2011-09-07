/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function makeDraggable()
{  
     $j('.draggable_menu_item').sortable({
        axis: 'y',
        dropOnEmpty: false,
        handle: '.menu-drag',
        cursor: 'crosshair',
        items: 'div',
        opacity: 0.4,
        scroll: true,
        update: function(){
            $j.ajax({
                type: 'post',
                data: $j(this.getAttribute("data-id")).sortable('serialize'),
                dataType: 'script',
                complete: function(request){
                    $j('.draggable_menu_item').effect('highlight');
                },
                url: '/menus/update_order'
            })
        }
    });

}



$j(document).ready(function(){
    $j('.draggable_menu_item').sortable({
        axis: 'y',
        dropOnEmpty: false,
        handle: '.menu-drag',
        cursor: 'crosshair',
        items: 'div',
        opacity: 0.4,
        scroll: true,
        update: function(){
            $j.ajax({
                type: 'post',
                data: $j(this.getAttribute("data-id")).sortable('serialize'),
                dataType: 'script',
                complete: function(request){
                    $j('.draggable_menu_item').effect('highlight');
                },
                url: '/menus/update_order'
            })
        }
    });

        $j("#alert").click(function() {
          alert(this.getAttribute("data-message"));
          return false;
        });
});