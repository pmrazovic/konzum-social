class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :manufacturer
      t.string :supplier
      t.string :sales_unit_of_measure
      t.string :price
    end
  end
end
