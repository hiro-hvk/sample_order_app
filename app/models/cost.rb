class Cost < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :subject

  #validates :sign, presence: {message: 'を入力してください'}
  
  
  
  def cost_unit_price
    hvk.to_i + fujii.to_i + imamoto.to_i
  end
  
  # 原価計
  def total_cost
    (quantity.to_i * (hvk.to_i + fujii.to_i + imamoto.to_i))
  end
  
  def hvk_total
    quantity.to_i * hvk.to_i
  end
  
  def fujii_total
    quantity.to_i * fujii.to_i
  end
  
  def imamoto_total
    quantity.to_i * imamoto.to_i
  end
  
  def selling_price_total
    quantity.to_i * selling_price.to_i
  end
  
  # 粗利益率
  def gross_margin_rate
    ((selling_price.to_i.quo((hvk.to_i + fujii.to_i + imamoto.to_i))*100).round)
  end
  
  # 粗利益
  def gross_profit
    (quantity.to_i * selling_price.to_i) - quantity.to_i * (hvk.to_i + fujii.to_i + imamoto.to_i)
  end
  
end