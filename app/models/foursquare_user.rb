class FoursquareUser < ActiveRecord::Base
  def name
    client.user_name
  end

  def client
    @client ||= FoursquareClient.new(access_token)
  end

  class << self
    def find_or_create_by_access_token(access_token)
      client = FoursquareClient.new(access_token)

      unless fsuser = self.find_by_foursquare_id(client.user_id)
        fsuser = self.new
        fsuser.foursquare_id = client.user_id
        fsuser.access_token = client.access_token
        fsuser.save!
      end
      user
    end
  end
end