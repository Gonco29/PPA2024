class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  validates :full_name, :email, :phone, :rut, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "no es válido" }

  # validates :phone, numericality: { only_integer: true, message: "debe contener solo números" }, length: { in: 8..15 }
  # validate :valid_rut_format

  # private

  # # Validación para el formato del RUT uruguayo
  # def valid_rut_format
  #   unless rut =~ /\A\d{1,8}-\d{1}\z/
  #     errors.add(:rut, "debe estar en el formato correcto (ejemplo: 12345678-9)")
  #   end
  # end
end
