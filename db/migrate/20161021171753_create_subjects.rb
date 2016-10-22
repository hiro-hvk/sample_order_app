class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :remarks
      t.integer :order_number
      t.string :delivery_date

      t.timestamps null: false
    end
  end
end
