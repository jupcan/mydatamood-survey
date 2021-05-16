class AddScoreDefaultValueInProducts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :products, :score, 0.0
  end
end
