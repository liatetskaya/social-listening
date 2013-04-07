class Profile < ActiveRecord::Base
  attr_accessible :address, :is_active, :status, :token
  belongs_to :user
end
