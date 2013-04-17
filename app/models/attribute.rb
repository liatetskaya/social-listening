class Attribute < ActiveRecord::Base
  attr_accessible :fs_id, :fs_is_active, :keyword, :tw_id, :tw_is_active
  belongs_to :user
end