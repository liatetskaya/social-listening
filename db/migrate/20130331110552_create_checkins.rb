class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :rm_service_id
      t.string :rm_merchant_id
      t.string :rm_user_id
      t.string :rm_created_at
      t.string :rm_message_id
      t.string :rm_message_url
      t.text :user
      t.text :post
      t.text :message
      t.string :notes
      t.string :client_id

    

      t.timestamps
    end
  end
end
