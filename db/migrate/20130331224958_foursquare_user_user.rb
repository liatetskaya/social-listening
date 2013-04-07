class FoursquareUserUser < ActiveRecord::Migration
  def change
    add_column :users, :foursquare_user_id, :integer
  end
end
