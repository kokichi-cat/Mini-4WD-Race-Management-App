class AddProfileToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :profile_picture, :string
    add_column :users, :introduction, :text
  end
end
