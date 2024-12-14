class AddPromoTextToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :promo_text, :text
  end
end
