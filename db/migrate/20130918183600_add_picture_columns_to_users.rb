class AddPictureColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :small_profile_image, :string
    add_column :users, :large_profile_image, :string
  end
end
