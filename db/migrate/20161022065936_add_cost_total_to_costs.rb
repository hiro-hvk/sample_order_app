class AddCostTotalToCosts < ActiveRecord::Migration
  def change
    add_column :costs, :cost_total, :string
    add_column :costs, :hvk_total, :string
    add_column :costs, :fujii_total, :string
    add_column :costs, :imamoto_total, :string
    add_column :costs, :selling_price_total, :string
    add_column :costs, :gross_margin_rate, :string
    add_column :costs, :gross_profit, :string
  end
end
