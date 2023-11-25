class AddCountyToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_reference :representatives, :county, foreign_key: true
  end
end
