class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :fb_uid
      t.string  :access_token
      t.string  :email

      t.timestamps
    end
    
    add_index :users, :fb_uid, :unique => true
  end

  def self.down
    drop_table :users
  end
end
