$(document).ready(function() {
	var form = $("#new_jpsy19_registration")
	var stripeKey = $('#stripe_key').val()

	var handler = StripeCheckout.configure({
		key: stripeKey,
		image: '',
		locale: 'auto',
		token: function(token) {
			// You can access the token ID with `token.id`.
			// Get the token ID to your server-side code for use.
			form.append($('<input type="hidden" name="stripeToken" />').val(token.id))
			form.get(0).submit()
		}
	})

	$(".stripe-button").attr('data-email', "test@google.com")

	$(".btn-success").on('click', function(e) {
		e.preventDefault()
		// Open Checkout with further options:
		var emailadress = $('#jpsy19_registration_email').val()
		var fees = $('input[name=jpsy19_registration\\[type_price\\]]:checked').val()
		var amounts = {
			'free': 0,
			'reduced': 5000,
			'normal': 10000
		}
		var amount = amounts[fees] || 0
		if ($('#cgvaccept:checkbox:checked').length > 0) {
			if (fees != "free") {
				handler.open({
					name: 'forms.hesav.ch',
					description: '',
					currency: 'chf',
					amount: amount,
					email: emailadress
				});
			} else {
				form.get(0).submit()
			}
		} else {
			alert("Vous devez accepter les conditions générales pour valider votre inscription")
		}
	})

})
