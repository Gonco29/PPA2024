class AddPromotionFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :on_sale, :boolean, default: false
    add_column :products, :discount_percentage, :integer, null: true
    add_column :products, :promotional_price, :decimal, precision: 10, scale: 2, null: true
  end
end
