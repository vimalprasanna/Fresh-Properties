# frozen_string_literal: true

# Add index to Property Table
class AddIndexOnProperty < ActiveRecord::Migration[5.0]
  def change
    add_index :properties, %i[owner_id availability id]
    add_index :properties, :id
  end
end
