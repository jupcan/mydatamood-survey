class AddScoreToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :score, :float
  end
end
