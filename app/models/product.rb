class Product < ApplicationRecord
  has_many_attached :photos

  validates :price, presence: true
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, if: :on_sale?

  before_save :calculate_promotional_price, if: :on_sale?

  def on_sale?
    on_sale
  end

  def calculate_promotional_price
    self.promotional_price = price * (1 - discount_percentage / 100.0)
  end

  include PgSearch::Model

  pg_search_scope :search_by,
    against: [:name, :details, :category],
    using: {
      tsearch: { prefix: true }
    }

end
