# frozen_string_literal: true

class RemoveCountyFromRepresentatives < ActiveRecord::Migration[5.2]
  def change
    remove_reference :representatives, :county, foreign_key: true
  end
end
