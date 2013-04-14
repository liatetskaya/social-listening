class RealtimeController < ApplicationController
  def foursquare
    resp = JSON.parse(params['checkin'])
    # TODO: verify push secret

    @checkin = Checkin.new

    @checkin.push_id = resp['id']
    @checkin.created_at = resp['created_at']
    @checkin.user_id = resp['user']['id']
    @checkin.user_gender = resp['user']['gender']
    @checkin.user_first_name = resp['user']['firstName']
    @checkin.user_last_name = resp['user']['lastName']
    @checkin.user_photo = resp['user']['photo']
    @checkin.venue_id = resp['venue']['id']
    @checkin.stat_checkins_count = resp['venue']['stats']['checkinsCount']
    @checkin.stat_users_count = resp['venue']['stats']['usersCount']
    @checkin.message = resp.to_s
    @checkin.save


    #user = FoursquareUser.find_by_foursquare_id(checkin['user']['id'])
    #user.client.create_checkin_reply(checkin['id'], text: "hello world!")
    return head :ok
  end

  def facebook
  end

  def facebookVerify
    # TODO: verify the token first (in params['hub.verify_token'])
    render text: params['hub.challenge']
  end
end
