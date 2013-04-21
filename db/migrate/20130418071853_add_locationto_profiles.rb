class AddLocationtoProfiles < ActiveRecord::Migration
   def change
    add_column :profiles, :location, :string
    add_column :profiles, :keywords, :string
    add_column :profiles, :last_message_timestamp, :string
  end
end
