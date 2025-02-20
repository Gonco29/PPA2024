class Product < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_many_attached :photos

  validates :name, :price, :category, :subcategory, presence: true
  validate :at_least_one_photo

  validates :price, numericality: { greater_than: 0 }, allow_nil: false
  validates :controls_included, :rack_meters, :arms, numericality: { only_integer: true, allow_nil: true }
  validates :installation_included, inclusion: { in: [true, false], message: "debe ser Sí o No" }
  validates :promotional_price, numericality: { greater_than: 0 }, allow_nil: true
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

  validates :promo_text, length: { maximum: 200 }, allow_blank: true
  validate :promo_text_line_limit

  before_save :calculate_discount_percentage, if: :on_sale?

  def promo_text_line_limit
    if promo_text.present? && promo_text.lines.count > 5
      errors.add(:promo_text, "No puede tener más de 5 líneas.")
    end
  end

  def on_sale?
    on_sale && promotional_price.present?
  end

  def calculate_discount_percentage
    if promotional_price.present? && price.present? && promotional_price > 0
      self.discount_percentage = ((1 - promotional_price.to_f / price.to_f) * 100)
    else
      self.discount_percentage = nil
    end
  end

  def current_price
    on_sale? ? promotional_price : price
  end

  def formatted_price
    number_with_delimiter(price, delimiter: '.', separator: '')
  end

  def formatted_promotional_price
    number_with_delimiter(promotional_price, delimiter: '.', separator: '')
  end

  def formatted_discount_percentage
    discount_percentage&.round || 0
  end

  def at_least_one_photo
    errors.add(:photos, "debe incluir al menos una foto") if photos.blank?
  end

  def warranty_description
    if installation_included
      "* Garantía 1 Año. Cubre defectos de fábrica. Repuestos y Servicio Técnico."
    else
      "* Garantía 1 Año. No cubre garantía por mala instalación."
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by,
                  against: %i[name details category subcategory installation_included promo_text product_type],
                  using: { tsearch: { prefix: true } }
end
