# frozen_string_literal: true

# Create Properties Table
class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :location
      t.integer :owner_id
      t.string :property_type
      t.string :availability
      t.attachment :image
      t.integer :tenant_id
      t.integer :rent
      t.timestamps null: false
    end
  end
end
