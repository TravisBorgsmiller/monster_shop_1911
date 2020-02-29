class Coupon < ApplicationRecord
  validates_presence_of :name
  validates_inclusion_of :value, in: 0..100, message: "value must be between 0 and 100."

  belongs_to :merchant 
  has_many :orders
end