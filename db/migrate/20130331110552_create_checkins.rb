class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :rm_service_id
      t.string :rm_merchant_id
      t.string :rm_user_id
      t.string :rm_created_at
      t.string :rm_message_id
      t.string :rm_message_url
      t.string :user_first_name
      t.string :user_last_name
      t.string :user_screen_name
      t.string :user_photo
      t.string :user_info
      t.string :post_text
      t.string :post_url
      t.string :picture
      t.string :location
      t.string :place_id
      t.text :notes
      t.text :message
      t.string :client_id

    

      t.timestamps
    end
  end
end
