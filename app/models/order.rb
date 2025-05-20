class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  def total_price
    line_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end 
end