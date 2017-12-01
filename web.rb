
require 'stripe'
# Set your secret key: remember to change this to your live secret key in production
# See your keys here: https://dashboard.stripe.com/account/apikeys
Stripe.api_key = "sk_test_fg6lxRP5xB7Hk8BnlBatro95"

# Token is created using Checkout or Elements!
# Get the payment token ID submitted by the form:
token = params[:stripeToken]

# Create a Customer:
customer = Stripe::Customer.create(
  :email => "paying.user@example.com",
  :source => token,
)

# Charge the Customer instead of the card:
charge = Stripe::Charge.create(
  :amount => 1000,
  :currency => "gbp",
  :customer => customer.id,
)

# YOUR CODE: Save the customer ID and other info in a database for later.

# YOUR CODE (LATER): When it's time to charge the customer again, retrieve the customer ID.
charge = Stripe::Charge.create(
  :amount => 1500, # $15.00 this time
  :currency => "gbp",
  :customer => customer_id, # Previously stored, then retrieved
)
