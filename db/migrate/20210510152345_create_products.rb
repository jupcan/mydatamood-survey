class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, id: false do |t|
      t.string :id, :primary_key => true
      t.string :name, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end