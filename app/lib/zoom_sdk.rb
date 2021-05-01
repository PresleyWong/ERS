 class ZoomSdk
  include HTTParty
  format :json
  base_uri "https://api.zoom.us/v2"

  def initialize(token)
    @options = {
      headers: {
        "Content-Type" => "application/json",
        "Host" => "api.zoom.us",
        "Authorization" => "Bearer #{token}"
      }
    }
  end

  def create_registrant(content, meeting_id)    
    payload = { body: content }
    payload.merge!(@options)   
    self.class.post("/meetings/#{meeting_id}/registrants", payload)
  end  
end

def jwt_token
  @zoom = Credential.where("api_name ILIKE ?", "%" + "zoom" + "%").first 
  valid_for_minutes = 90
  exp = Time.now.to_i + (valid_for_minutes*60)
  payload = {"iss": @zoom&.api_key, "exp": exp}
  secret = @zoom&.api_secret
  token = JWT.encode payload, secret, 'HS256'
end