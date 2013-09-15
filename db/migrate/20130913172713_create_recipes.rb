class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.string :instructions

      t.timestamps
    end
  end
end
