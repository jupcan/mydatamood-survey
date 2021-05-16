class ChangeScoreTypeInInterests < ActiveRecord::Migration[6.1]
  def change
    change_column :interests, :score, :float
  end
end
