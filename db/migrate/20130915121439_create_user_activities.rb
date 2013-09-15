class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.references :user
      t.references :feedable, :polymorphic => true
      t.timestamps
    end
  end
end
