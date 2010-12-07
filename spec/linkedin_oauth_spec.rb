#!/usr/local/bin/ruby
require 'rubygems'
require 'linkedin_oauth'

LINKEDIN_API_KEY = ""
SECRET_KEY = ""
session = {}

consumer = LinkedinOauth.create_linkedin_consumer
request_token = LinkedinOauth.create_linkedin_request_token(
  consumer, "http://localhost:3000/session/linkedin_oauth_callback"
)

puts request_token.token
puts request_token.secret
session[:request_token] = request_token.token
session[:request_token_secret] = request_token.secret

