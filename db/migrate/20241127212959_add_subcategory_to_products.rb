class AddSubcategoryToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :subcategory, :string
  end
end
