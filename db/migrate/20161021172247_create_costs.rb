class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.references :subject, index: true, foreign_key: true
      t.string :material
      t.string :product
      t.string :pressure
      t.string :size
      t.string :quantity
      t.string :hvk
      t.string :fujii
      t.string :imamoto
      t.string :selling_price
      t.text :remarks
      t.string :sign
      t.string :product_model
      t.string :unit

      t.timestamps null: false
    end
  end
end
