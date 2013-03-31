class AttributeUser < ActiveRecord::Migration
  def change
    add_column :attributes, :user_id, :integer
  end
end
