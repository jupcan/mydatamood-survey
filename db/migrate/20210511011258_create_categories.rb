class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :category, null: false
      t.integer :score

      t.timestamps
    end
  end
end
