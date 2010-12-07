require 'oauth'

module LinkedinOauth
  
  def self.create_linkedin_consumer
    OAuth::Consumer.new(
      LINKEDIN_API_KEY,
      SECRET_KEY,
      :site => "https://api.linkedin.com",
      :request_token_path => "/uas/oauth/requestToken",
      :access_token_path  => "/uas/oauth/accessToken",
      :authorize_path     => "/uas/oauth/authorize"
    )
  end
  
  def self.create_linkedin_request_token(consumer, callback)
    request_token = consumer.get_request_token(
      :oauth_callback => callback
    )
    return request_token
  end
  
  def self.recreate_linkedin_request_token_from_session(consumer, session)
    OAuth::RequestToken.new(
      consumer,
      session[:request_token],
      session[:request_token_secret]
    )
  end
  
  def self.create_linkedin_access_token(request_token, oauth_verifier, oauth_token)
    access_token = request_token.get_access_token(
      :oauth_consumer_key => LINKEDIN_API_KEY,
      :oauth_verifier => oauth_verifier,
      :oauth_token => oauth_token
    )
    return access_token
  end
  
  def self.recreate_linkedin_access_token_from_session(consumer, session)
    OAuth::AccessToken.new(
      consumer,
      session[:access_token],
      session[:access_token_secret]
    )
  end
  
  def self.current_linkedin_user(access_token)
    my_profile_resp = access_token.get('/v1/people/~:(id,first-name,last-name,industry)')
    this_person = Hash.from_xml( my_profile_resp.body )
    return this_person["person"]
  end
  
end
