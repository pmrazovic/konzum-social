class ChangePriceForProducts < ActiveRecord::Migration
  def change
    remove_column :products, :price
    add_column :products, :price, :decimal, :precision => 17, :scale => 2
  end
end
