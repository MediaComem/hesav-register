$( document ).ready(function() {
  $(".stripe-button").attr('data-email',"test@google.com")
  var handler = StripeCheckout.configure({
	  key: 'pk_test_oVKjxRsLBU75cvBPaxgu2GGV',
	  image: '',
	  locale: 'auto',
	  token: function(token) {
	    // You can access the token ID with `token.id`.
	    // Get the token ID to your server-side code for use.
	    $("#new_psy17_registration").append($("<input type=\"hidden\" name=\"stripeToken\" />").val(token.id));
	    $("#new_psy17_registration").get(0).submit()
	  }
	});
	$(".btn-success").on('click', function(e) {
		e.preventDefault();
	  // Open Checkout with further options:
	  var emailadress = $('#psy17_registration_email').val()
	  var fees = $('input[name=psy17_registration\\[type_price\\]]:checked').val()
	  var amount = 15000
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
		  	$("#new_psy17_registration").get(0).submit()
		  } 
    }else{
    	alert("Vous devez accepter les conditions générales pour valider votre inscription")
    }
	});
});