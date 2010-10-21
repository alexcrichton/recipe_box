class AddUserFbMetadata < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_username, :string
    add_column :users, :timezone, :integer
    change_column :users, :fb_uid, :string
  end

  def self.down
    remove_column :users, :fb_username
    remove_column :users, :timezone
    change_column :users, :fb_uid, :integer
  end
end
