class AddUserFbMetadata < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_username, :string
    add_column :users, :timezone, :integer
  end

  def self.down
    remove_column :users, :fb_username
    remove_column :users, :timezone
  end
end
