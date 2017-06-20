$( document ).ready(function() {
	console.log("trm30")
	$(".btn-success").on('click', function(e) {
		e.preventDefault();
	  // Open Checkout with further options:
	  if( $('#cgvaccept:checkbox:checked').length>0){
		  	$("#new_trm30_registration").get(0).submit()
    }else{
    	alert("Vous devez accepter les conditions générales pour valider votre inscription")
    }
	});
});