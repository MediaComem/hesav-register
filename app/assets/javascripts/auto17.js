$( document ).ready(function() {
  $(".stripe-button").attr('data-email',"test@google.com")
  var handler = StripeCheckout.configure({
	  key: 'pk_test_oVKjxRsLBU75cvBPaxgu2GGV',
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
	  var amount = 10000
	  if(fees === "reduced"){
	  	amount = 5000
	  }
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
	});
});