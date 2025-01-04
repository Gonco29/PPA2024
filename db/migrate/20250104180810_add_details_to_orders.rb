class AddDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :email, :string
    add_column :orders, :phone, :string
    add_column :orders, :rut, :string
  end
end
