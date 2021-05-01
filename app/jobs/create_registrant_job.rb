require 'jwt'
require 'zoom_sdk'

class CreateRegistrantJob < ApplicationJob
  queue_as :default

  def perform(user_id, event_id, language)
    @user = User.find(user_id)
    @event = Event.find(event_id)

    zoom = ZoomSdk.new(jwt_token)
    hash_format = Hash.new

    hash_format["email"] = @user.email
    hash_format["first_name"] = @user.generate_first_name
    hash_format["last_name"] = @user.generate_last_name
    # hash_format["email"] = "myemail@mycompany.com"
    # hash_format["first_name"] = "EBPYJ"
    # hash_format["last_name"] = "WPL"


    begin
      resp = zoom.create_registrant(hash_format.to_json, @event.meeting_id1)    
      print resp
      if resp["join_url"]
        Appointment.create(user_id: user_id, event_id: event_id, language: language, join_url: resp['join_url'])
      end
    rescue
      return
    end

  end

end
