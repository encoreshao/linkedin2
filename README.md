= Likedin2

A Ruby wrapper for Linkedin API(OAuth2).It is based on {OAuth2 gem}[https://github.com/intridea/oauth2], thanks for his hard-working.I have wrapped most of the APIs Linkedin defined.Note that all of the privilege APIs haven't been tested yet, since I don't get the authorization to use it.

== Installation

  gem 'linkedin2', git: 'git@github.com:encoreshao/linkedin2.git'
  
== Usage Examples

Config your api_key, api_secret and redrect_uri somewhere like development.rb.

  LinkedIn2::Config.api_key = "xnismshhjajak"
  LinkedIn2::Config.api_secret = "xnismshhjajakxnismshhjajakxnismshhjajak"
  LinkedIn2::Config.redirect_uri = "http://www.example.com/uas/linkedin_oauth2/callback"

Ok, now you are ready to enjoy it. LinkedIn has provided several ways to get your access token, and you can easily get it using LinkedIn2.


== API

You can find them in /lib/linkedin2/api/.Note that all methods 
    
    # Your API keys at https://www.linkedin.com/secure/developer
    client = LinkedIn2::Client.new

    client.get_token_from_hash({access_token: Authentication.first.token})

    client.profile({fields: ['id']})

    client.company({id: #{linkedin_id}, fields: ['id', 'name']})

    client.search({keywords: 'Facebook'}, 'company') 
  
== Copyright

Copyright (c) 2011 Encore. See LICENSE for details.
