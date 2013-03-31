class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :push_id
      t.integer :created_at
      t.string :user_gender
      t.string :user_id
      t.string :user_first_name
      t.string :user_last_name
      t.string :user_photo
      t.string :venue_id
      t.integer :stat_checkins_count
      t.string :stat_users_count
      t.text :message
      t.string :notes
      t.integer :user_profile

      t.timestamps
    end
  end
end
