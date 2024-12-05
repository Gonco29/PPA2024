class Product < ApplicationRecord
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
  validates :installation_included, inclusion: { in: [true, false] }

  # Métodos relacionados con la promoción (manteniendo los existentes)
  before_save :calculate_promotional_price, if: :on_sale?

  def on_sale?
    on_sale
  end

  def calculate_promotional_price
    self.promotional_price = price * (1 - discount_percentage / 100.0)
  end

  def current_price
    if on_sale?
      promotional_price
    else
      price
    end
  end

  # Método para validar que haya al menos una foto
  def at_least_one_photo
    errors.add(:photos, "debe incluir al menos una foto") if photos.blank?
  end

  # Método para la descripción de la garantía
  def warranty_description
    if installation_included
      "1 Año. Cubre defectos de fábrica. Repuestos y Servicio Técnico."
    else
      "1 Año. No cubre garantía por mala instalación."
    end
  end

  # Búsqueda con pg_search
  include PgSearch::Model

  pg_search_scope :search_by,
    against: [:name, :details, :category, :subcategory, :installation_included, :product_type],
    using: {
      tsearch: { prefix: true }
    }
end
