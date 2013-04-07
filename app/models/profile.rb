class Profile < ActiveRecord::Base
  attr_accessible :address, :is_active, :status, :token, :service_id
  belongs_to :user
end
