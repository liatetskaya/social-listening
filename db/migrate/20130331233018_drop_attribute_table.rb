class DropAttributeTable < ActiveRecord::Migration
  def up
    drop_table :attributes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end