class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :interests do |t|
      t.references :user, type: :string, null: false, foreign_key: true
      t.references :product, type: :string, null: false, foreign_key: true
      t.integer :score, null: false
      t.index [:id, :product_id], unique: true

      t.timestamps
    end
  end
end
