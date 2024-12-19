class ChangePriceAndPromotionalPriceToInteger < ActiveRecord::Migration[6.0]
  def up
    change_column :products, :price, :integer, using: 'price::integer'
    change_column :products, :promotional_price, :integer, using: 'promotional_price::integer'
  end

  def down
    change_column :products, :price, :string
    change_column :products, :promotional_price, :string
  end
end
