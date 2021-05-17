# frozen_string_literal: true

class AddScoreDefaultValueInCategories < ActiveRecord::Migration[6.1]
  def change
    change_column_default :categories, :score, 0.0
  end
end
