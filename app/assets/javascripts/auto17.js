$( document ).ready(function() {
	console.log("Auto167")
  $(".stripe-button").attr('data-email',"test@google.com")
  var handler = StripeCheckout.configure({
	  key: 'pk_live_LEMIGU9HW4SfXh87LyMyQw8g',
	  image: '',
	  locale: 'auto',
	  token: function(token) {
	    // You can access the token ID with `token.id`.
	    // Get the token ID to your server-side code for use.
	    $("#new_auto17_registration").append($("<input type=\"hidden\" name=\"stripeToken\" />").val(token.id));
	    $("#new_auto17_registration").get(0).submit()
	  }
	});
	$(".btn-success").on('click', function(e) {
		e.preventDefault();
	  // Open Checkout with further options:
	  var emailadress = $('#auto17_registration_email').val()
	  var fees = $('input[name=auto17_registration\\[type_price\\]]:checked').val()
	  var amount = 14000
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
		  	$("#new_auto17_registration").get(0).submit()
		  } 
    }else{
    	alert("Vous devez accepter les conditions générales pour valider votre inscription")
    }
	});
});