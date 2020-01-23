# frozen_string_literal: true

# Rename column password
class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :password, :password_hash
  end
end
