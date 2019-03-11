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
			form.append($('<input type="hidden" name="stripeToken" id="stripeToken" />').val(token.id))
			form.submit()
		}
	})

	form.on('submit', function(e) {
		if (!$('#cgvaccept').is(':checked')) {
			e.preventDefault()
			alert("Vous devez accepter les conditions générales pour valider votre inscription")
		} else {
			if (fees != "free" && document.getElementById('stripeToken') === null) {
				// Do not submit the form when user have to pay something and did not already do it.
				e.preventDefault()
				var emailadress = $('#jpsy19_registration_email').val()
				var fees = $('input[name=jpsy19_registration\\[type_price\\]]:checked').val()
				var amounts = {
					'free': 0,
					'reduced': 5000,
					'normal': 10000
				}
				// Set the amount to 0 if fees does not exist as a valid amount
				var amount = amounts[ fees ] || 0
				handler.open({
					name: 'forms.hesav.ch',
					description: '',
					currency: 'chf',
					amount: amount,
					email: emailadress
				});
			}
		}
	});

})
