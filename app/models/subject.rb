class Subject < ActiveRecord::Base
  has_many :costs, dependent: :destroy
  accepts_nested_attributes_for :costs, allow_destroy: true
    
end
