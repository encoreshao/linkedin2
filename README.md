= Likedin2

A Ruby wrapper for Linkedin API(OAuth2).It is based on {OAuth2 gem}[https://github.com/intridea/oauth2], thanks for his hard-working.I have wrapped most of the APIs Linkedin defined.Note that all of the privilege APIs haven't been tested yet, since I don't get the authorization to use it.

== Installation

  gem 'linkedin2', git: 'git@github.com:encoreshao/linkedin2.git'
  
== Usage Examples

Config your api_key, api_secret and redrect_uri somewhere like development.rb.

  Linkedin2::Config.api_key = "xnismshhjajak"
  Linkedin2::Config.api_secret = "xnismshhjajakxnismshhjajakxnismshhjajak"
  Linkedin2::Config.redirect_uri = "http://www.example.com/uas/linkedin_oauth2/callback"

Ok, now you are ready to enjoy it. LinkedIn has provided several ways to get your access token, and you can easily get it using Linkedin2.

1.The Authorization Code strategy with response_type set to code
  
  # get authorize_url
  client = Linkedin2::Client.new
  client.auth_code.authorize_url
  # => "https://www.linkedin.com/uas/oauth2/authorization?response_type=code
                                           &client_id=YOUR_API_KEY
                                           &scope=SCOPE
                                           &state=STATE
                                           &redirect_uri=YOUR_REDIRECT_URI"

  # get token using authorization_code
  # Linkedin2::Client.from_code is a shortcut for client.auth_code.get_token("authorization_code_value")
  client = Linkedin2::Client.from_code("authorization_code_value")
  
2.The Authorization Code strategy with response_type set to token
  
  # get authorize_url with response_type set to token
  client = Linkedin2::Client.new
  client.auth_code.authorize_url(:response_type => "token")
  # => "https://www.linkedin.com/uas/oauth2/authorization?response_type=code
                                           &client_id=YOUR_API_KEY
                                           &scope=SCOPE
                                           &state=STATE
                                           &redirect_uri=YOUR_REDIRECT_URI"
  
  # get token from callback hash like this /callback#access_token=6874dd3766b35536abcb76a9e3a57867&expires_in=86400
  client = Linkedin2::Client.from_hash(:access_token => "6874dd3766b35536abcb76a9e3a57867", :expires_in => 86400)
  
3.The Resource Owner Password Credentials strategy
  
  # get token with user's password
  client = Linkedin2::Client.new
  client.password.get_token('username', 'password')
  
4.Signed Request strategy

Follow this link to read more about this strategy.{站内应用开发指南}[https://developer.linkedin.com/documents/authentication]

  
  # get token using signed_request
  client = Linkedin2::Client.from_signed_request("signed_request-posted-by-linkedin")
  
  # you can see what the signed_request exactly is by
  client.signed_request.unsigned_request
  # => {"user"=>{"country"=>"cn", "locale"=>""}, "algorithm"=>"HMAC-SHA256", "issued_at"=>1320298983, "expires"=>1320385383, "oauth_token"=>"0ca59d99f92436d65ae23115604a3185", "user_id"=>1234567890}

5.Refresh your token

Note that you could refresh your token only when you can get the refresh_token.

  
  client.refresh!
  
You can check if you are authorized by

  client.is_authorized?
  # => true
  
If you are authorized, then you can do whatever you want now.

  response = client.account.get_uid
  # => #<OAuth2::Response:: ...>
  
  response.parsed
  # => {"uid"=>1234567890}


== API

You can find them in /lib/linkedin2/api/.Note that all methods 
  
== Copyright

Copyright (c) 2011 Encore. See LICENSE for details.
