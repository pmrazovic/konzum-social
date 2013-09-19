class CreateListUsers < ActiveRecord::Migration
  def change
    create_table :list_users do |t|
      t.integer :user_id
      t.integer :list_id
    end
  end
end
