    var oTable;
    var vendorTable;
    
    
    function wait(msecs)
{
var start = new Date().getTime();
var cur = start
while(cur - start < msecs)
{
cur = new Date().getTime();
}	
} 
    
    
    
    
$j.extend({
    getUrlVars: function(){
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for(var i = 0; i < hashes.length; i++)
        {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    },
    getUrlVar: function(name){
        return $j.getUrlVars()[name];
    }
});


$j(document).ready(function() {
    $j("#loader_progress").show();
    oTable=$j('#example').dataTable({
 "aLengthMenu": [[-1, 10, 25, 50], ["All", 10, 25, 50]]
 });
    $j("#loader_progress").hide();


} );


$j(function setupinventory(){
    var $modal = $j('#modal'),
    $modal_close = $modal.find('.close'),
    $modal_container = $j('#modal-container');

    // This bit can be confusing. Since Rails.js sends an accept header asking for
    // javascript, but we want it to return HTML, we need to override this instead.
     $j('#newinventoryitems').live('ajax:beforeSend', function(e, xhr, settings){
        xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);
        $j("#loader_progress").show();

    });
    $j('#newinventoryitems').live('ajax:success', function(xhr, data, status){
        $modal
        .html(data)
        .prepend($modal_close)
        .css('top', $j(window).scrollTop() + 40)
        .show();
        $modal_container.show();
        $j(".best_in_place").best_in_place();

    });
         $j('#selectvendor').live('ajax:success', function(xhr, data, status){
        $modal
        .html(data)
        .prepend($modal_close)
        .css('top', $j(window).scrollTop() + 40)
        .show();
        $modal_container.show();
        vendorTable=$j('#vendor').dataTable();

    });
    
    
    $j('#selectvendor').live('ajax:beforeSend', function(e, xhr, settings){
        xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);
        $j("#loader_progress").show();


    });

    
    $j('#newinventoryitem').live('ajax:beforeSend', function(e, xhr, settings){
        xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);
        $j("#loader_progress").show();

    });
    


    // Handle modal links with the data-remote attribute
    $j('#newinventoryitem').live('ajax:success', function(xhr, data, status){
        var $prod_id = $j("#product-id").text();
   
        $j.post('/products/show_inventory/' + $prod_id, function(data) 
        {
            $j('#inventory-container').html(data);
            $j("#loader_progress").hide();
            oTable=$j('#example').dataTable();
       //     setupinventory();
            $j(".inventory-list").best_in_place();

        });
    });
  
    $j('#editinventoryitem').live('ajax:beforeSend', function(e, xhr, settings){
        xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);
        $j("#loader_progress").show();

    });

    // Handle modal links with the data-remote attribute
    $j('#editinventoryitem').live('ajax:success', function(xhr, data, status){
        $modal
        .html(data)
        .prepend($modal_close)
        .css('top', $j(window).scrollTop() + 40)
        .show();
        $modal_container.show();
        $j(".best_in_place").best_in_place();
    });
    // Handle modal links with the data-remote attribute
    $j('#deleteinventoryitem').live('ajax:success', function(xhr, data, status){
        $j("#loader_progress").show();
        theTarget=this.parentNode.parentNode;
        var aPos = oTable.fnGetPosition( theTarget );
 //       var aData = oTable.fnGetData( aPos[0] );
         oTable.fnDeleteRow(aPos) ;
        $j("#loader_progress").hide();
     });
     
    $j('#vendor-list .sorting_1').live('mousedown', function(){
        
               $j(this.parentNode).addClass('row_selected');
       //    $j(event.target.parentNode).addClass('row_selected');
      //        console.log("mouse down");
     //         wait(1000);

    });
    
    $j('#vendor-list .sorting_1').live('click', function(){
    
            
      //$j(event.target.parentNode).addClass('row_selected');
        $j(this.parentNode).addClass('row_selected');
        
        
      var $prod_id = $j("#product-id").text();
        var $vend_id = $j(this).find('#company-id').text();
        var $vend_name = $j(this).find("#company-name").text();
        console.log("prod_id: "+$prod_id);
        console.log("vend_id: "+$vend_id);
                console.log("vend_name: "+$vend_name);

        var $return_data = {
            vendor: 
            {
                vendor_id: $vend_id
            }
        }
      
        csrf_token = $j('meta[name=csrf-token]').attr('content');
        csrf_param = $j('meta[name=csrf-param]').attr('content');

        var data = "_method=put";
        data += "&" + "product" + '[' + "vender_id" + ']=' + encodeURIComponent($vend_id);

        if (csrf_param !== undefined && csrf_token !== undefined) {
            data += "&" + csrf_param + "=" + encodeURIComponent(csrf_token);
        }
      
      
        $j.ajax({
            type: "POST",
            url: "/products/update/"+$prod_id,
            data: data,
            dataType: "script",
            callback: null
        });
   //    $j(event.target.parentNode).removeClass('row_selected');

        $modal_container.hide();
        $modal.hide();
        $j("#loader_progress").hide();
        $j("#field_vendor_id").html($vend_name);
        
        return false;
        
    });
    // Hide close button click
    $j('.close', '#modal').live('click', function(){
        $modal_container.hide();
        $modal.hide();
        $j("#loader_progress").hide();

//        var $prod_id = $j("#product-id").text();
//   
//        $j.post('/products/show_inventory/' + $prod_id, function(data) 
//        {
//            $j('#inventory-container').html(data);
//            $j("#loader_progress").hide();
//            oTable=$j('#example').dataTable();
//            setupinventory();
//            $j(".best_in_place").best_in_place();
//
//        });
//        $j(".best_in_place").best_in_place();
//        oTable=$j('#example').dataTable();

        return false;
    });

//   $j('#example tbody tr').click( function () {
////  $j('#deleteinventoryitem').click( function () {
//       /* Get the position of the current data from the node */
//       theTarget=$j(this).closest("tr");
//       
//        console.log("this: ");
//        console.log(this);
//        
//        var aPos = oTable.fnGetPosition( this );
//        console.log(aPos)
//        /* Get the data array for this row */
//        var aData = oTable.fnGetData( aPos[0] );
//         console.log(aData)
//         
//         oTable.fnDeleteRow(aPos) ;
//         oTable=$j('#example').dataTable();
//
//        /* Update the data array and return the value */
//       // aData[ aPos[1] ] = 'clicked';
//        //this.innerHTML = 'clicked';
//    } );

//$j('#deleteinventoryitem').click( function () {
//       /* Get the position of the current data from the node */
//       theTarget=this.parentNode.parentNode;
//       
//        console.log("theTarget:")
//        console.log(theTarget);
//        var aPos = oTable.fnGetPosition( theTarget );
//        console.log(aPos)
//        /* Get the data array for this row */
//        var aData = oTable.fnGetData( aPos[0] );
//         console.log(aData)
//         
//         oTable.fnDeleteRow(aPos) ;
//         oTable=$j('#example').dataTable();
//
//        /* Update the data array and return the value */
//       // aData[ aPos[1] ] = 'clicked';
//        //this.innerHTML = 'clicked';
//    } );
     
     
// $j("#deleteinventoryitem").click( function () {
// 
//     window.alert("clicked");
//          var theTarget= $j(event.target.parentNode).closest("tr");
//          console.log(theTarget);
//          console.log(this);
//          console.log($j('#example tbody tr'))
//          var aPos = oTable.fnGetPosition(theTarget);
//          console.log(aPos);
// 
//       var aData = oTable.fnGetData( aPos[0] );
//       console.log(aData);
// });
});
