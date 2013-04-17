class AddServiceIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :service_id, :string
  end
end
