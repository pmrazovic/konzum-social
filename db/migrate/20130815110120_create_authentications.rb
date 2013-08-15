class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :users
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
