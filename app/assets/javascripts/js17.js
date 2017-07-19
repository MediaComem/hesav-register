$( document ).ready(function() {
  var handler = StripeCheckout.configure({
	  key: 'pk_live_LEMIGU9HW4SfXh87LyMyQw8g',
	  image: '',
	  locale: 'auto',
	  token: function(token) {
	    // You can access the token ID with `token.id`.
	    // Get the token ID to your server-side code for use.
	    $("#new_js17_registration").append($("<input type=\"hidden\" name=\"stripeToken\" />").val(token.id));
	    $("#new_js17_registration").get(0).submit()
	  }
	});
	$(".btn-success").on('click', function(e) {
		e.preventDefault();
	  // Open Checkout with further options:
	  var emailadress = $('#js17_registration_email').val()
	  var fees = $('input[name=js17_registration\\[type_price\\]]:checked').val()
	  var amount = 0
	  if(fees === "reduced"){
	  	amount = 5000
	  }
	  if(fees === "normal"){
	  	amount = 8000
	  }
	  if( $('#cgvaccept:checkbox:checked').length>0){
  		if(fees != "free"){
		  	handler.open({
		    name: 'forms.hesav.ch',
		    description: '',
		    currency: 'chf',
		    amount: amount,
		    email: emailadress
			  });
		  }else{
		  	$("#new_js17_registration").get(0).submit()
		  } 
    }else{
    	alert("Vous devez accepter les conditions générales pour valider votre inscription")
    }
	});
});