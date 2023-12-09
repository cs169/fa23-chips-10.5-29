# frozen_string_literal: true

class RemoveRatingFromNewsItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :news_items, :rating, :integer
  end
end
