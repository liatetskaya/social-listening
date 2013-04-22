class AddLastMessageIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :last_message_id, :string
  end
end
