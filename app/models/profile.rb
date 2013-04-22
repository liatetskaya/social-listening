class Profile < ActiveRecord::Base
  attr_accessible :address, :is_active, :status, :token, :service, :location, :keywords, :service_id
  belongs_to :user
  has_many :checkins
end
