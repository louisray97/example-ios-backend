require 'sinatra'
require 'stripe'
require 'dotenv'
require 'json'
require 'encrypted_cookie'

Dotenv.load
Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

use Rack::Session::EncryptedCookie,
  :secret => 'replace_me_with_a_real_secret_key' # Actually use something secret here!

get '/' do
  status 200
  return "Great, your backend is set up. Now you can configure the Stripe example apps to point here."
end
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

