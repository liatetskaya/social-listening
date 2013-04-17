class Profile < ActiveRecord::Base
  attr_accessible :address, :is_active, :status, :token, :service
  belongs_to :user
end
