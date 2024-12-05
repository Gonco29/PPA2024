class UpdateProductsForRealData < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :sku, :string
    add_column :products, :warranty, :text
    add_column :products, :power, :string
    add_column :products, :controls_included, :integer
    add_column :products, :rack_meters, :integer
    add_column :products, :arms, :integer
    add_column :products, :usage_type, :string
    add_column :products, :gate_max_length, :decimal, precision: 5, scale: 2
    add_column :products, :installation_included, :boolean, default: false
    add_column :products, :indication, :text
    add_column :products, :product_type, :string
  end
end
