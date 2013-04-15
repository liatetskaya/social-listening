class RealtimeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def foursquare
    resp = JSON.parse(params['checkin'])
    # TODO: verify push secret

  @checkin = Checkin.new

          @checkin.rm_service_id = "FOURSQUARE"
          @checkin.rm_message_id = resp['id']
          @checkin.rm_user_id = resp['user']['id']
          @checkin.rm_merchant_id = resp['venue']['id']
          @checkin.user_first_name = resp['user']['firstName']
          @checkin.user_last_name = resp['user']['lastName']
          @checkin.user_photo = resp['user']['photo']
  #        @checkin.user_screen_name = resp['user']['screen_name']
          @checkin.user_info= resp['venue']['stats']['checkinsCount']
          @checkin.post_text= resp['user']['text']
 #         @checkin.post_url= resp['user']['name']
 #         @checkin.picture= resp['user']['']
          @checkin.coordinates= resp['user']['coordinates']
  #        @checkin.place_id= resp['user']['name']
          @checkin.message= resp.to_s
          @checkin.save

    #user = FoursquareUser.find_by_foursquare_id(checkin['user']['id'])
    #user.client.create_checkin_reply(checkin['id'], text: "hello world!")
    return head :ok
  end

  def facebook
    resp = JSON.parse(request.body.read)
    Rails.logger.info resp.inspect
    return head :ok
  end

  def facebookVerify
    # TODO: verify the token first (in params['hub.verify_token'])
    render text: params['hub.challenge']
  end
end
