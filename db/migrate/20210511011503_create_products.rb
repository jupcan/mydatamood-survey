class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, id: false do |t|
      t.string :id, primary_key: true
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end