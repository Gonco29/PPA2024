class AddTermsAndConditionsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :terms_and_conditions, :boolean, default: false, null: false
  end
end
