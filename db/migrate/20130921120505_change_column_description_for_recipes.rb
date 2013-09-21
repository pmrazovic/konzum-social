class ChangeColumnDescriptionForRecipes < ActiveRecord::Migration
  def change
    change_column :recipes, :instructions, :text
  end
end
