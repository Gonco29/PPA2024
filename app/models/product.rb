class Product < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  # Relación con ActiveStorage para manejar fotos
  has_many_attached :photos

  # Validaciones obligatorias
  validates :name, :price, :category, :subcategory, presence: true
  validate :at_least_one_photo

  # Validaciones opcionales
  validates :price, numericality: { greater_than: 0 }, allow_nil: false
  validates :controls_included, :rack_meters, :arms, numericality: { only_integer: true, allow_nil: true }
  validates :installation_included, inclusion: { in: [true, false], message: "debe ser Sí o No" }
  validates :promotional_price, presence: true, if: :on_sale?
  validates :discount_percentage, presence: true,
                                  numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
                                  if: :on_sale?

  validates :promo_text, length: { maximum: 200 }, allow_blank: true
  validate :promo_text_line_limit

  # Callbacks
  before_save :calculate_promotional_price, if: :on_sale?

  # Métodos relacionados con la promoción
  def promo_text_line_limit
    if promo_text.present? && promo_text.lines.count > 5
      errors.add(:promo_text, "No puede tener más de 5 líneas.")
    end
  end

  def on_sale?
    on_sale
  end

  def calculate_promotional_price
    self.promotional_price = price * (1 - discount_percentage / 100.0)
  end

  def current_price
    if on_sale? && promotional_price.present?
      promotional_price
    else
      price
    end
  end

  # Métodos para formatear precios
  def formatted_price
    number_with_delimiter(price, delimiter: '.', separator: '')
  end

  def formatted_promotional_price
    number_with_delimiter(promotional_price, delimiter: '.', separator: '')
  end

  # Método para validar que haya al menos una foto
  def at_least_one_photo
    errors.add(:photos, "debe incluir al menos una foto") if photos.blank?
  end

  # Método para la descripción de la garantía
  def warranty_description
    if installation_included
      "* Garantía 1 Año. Cubre defectos de fábrica. Repuestos y Servicio Técnico."
    else
      "* Garantía 1 Año. No cubre garantía por mala instalación."
    end
  end

  # Búsqueda con pg_search
  include PgSearch::Model

  pg_search_scope :search_by,
                  against: %i[name details category subcategory installation_included promo_text product_type],
                  using: {
                    tsearch: { prefix: true }
                  }
end
