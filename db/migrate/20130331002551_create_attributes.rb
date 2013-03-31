class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :fs_id
      t.boolean :fs_is_active
      t.string :tw_id
      t.boolean :tw_is_active
      t.string :keyword

      t.timestamps
    end
  end
end
