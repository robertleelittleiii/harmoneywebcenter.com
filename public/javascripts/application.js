// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function sz(t) {
a = t.value.split('\n');
b=1;
for (x=0;x < a.length; x++) { if (a[x].length >= t.cols) b+= Math.floor(a[x].length/t.cols);
}
b+= a.length;
if (b > t.rows) t.rows = b;
}


$j('.delete_menu').bind('ajax:success', function() {
    $j(this).closest('table').fadeOut();
})


$j(document).ready(function(){
         $j(".best_in_place").best_in_place();
         $j( ".datepicker" ).datepicker();

         $j('#page_body_tbl').css('height','450');

    if( $j('.main_tabnav').is(':hidden') )
    {
         $j('#content_body').css('height','627');     }
    else
    {
         $j('#content_body').css('height','592');
         //$j('#content_body').height(465);

     }
     
     $j.fn.autoGrowInput = function(o) {

    o = $j.extend({
        maxWidth: 1000,
        minWidth: 0,
        comfortZone: 70
    }, o);

    this.filter('input:text').each(function(){

        var minWidth = o.minWidth || $(this).width(),
            val = '',
            input = $(this),
            testSubject = $('<tester/>').css({
                position: 'absolute',
                top: -9999,
                left: -9999,
                width: 'auto',
                fontSize: input.css('fontSize'),
                fontFamily: input.css('fontFamily'),
                fontWeight: input.css('fontWeight'),
                letterSpacing: input.css('letterSpacing'),
                whiteSpace: 'nowrap'
            }),
            check = function() {

                if (val === (val = input.val())) {return;}

                // Enter new content into testSubject
                var escaped = val.replace(/&/g, '&amp;').replace(/\s/g,' ').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                testSubject.html(escaped);

                // Calculate new width + whether to change
                var testerWidth = testSubject.width(),
                    newWidth = (testerWidth + o.comfortZone) >= minWidth ? testerWidth + o.comfortZone : minWidth,
                    currentWidth = input.width(),
                    isValidWidthChange = (newWidth < currentWidth && newWidth >= minWidth)
                                         || (newWidth > minWidth && newWidth < o.maxWidth);

                // Animate width
                if (isValidWidthChange) {
                    input.width(newWidth);
                }

            };

        testSubject.insertAfter(input);

        $j(this).bind('keyup keydown blur update', check);

    });

    return this;

};
     
   }
 )


