class AddAccionamientoToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :accionamiento, :integer
  end
end
