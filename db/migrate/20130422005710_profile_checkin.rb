class ProfileCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :profile_id, :integer
  end
end
