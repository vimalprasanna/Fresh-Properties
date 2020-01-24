# frozen_string_literal: true

# remove column availability
class RemovAvailabilityColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :properties, :availability
  end
end
