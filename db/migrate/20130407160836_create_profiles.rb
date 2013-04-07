class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :token
      t.string :address
      t.boolean :is_active
      t.string :status

      t.timestamps
    end
  end
end
