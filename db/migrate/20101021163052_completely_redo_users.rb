class CompletelyRedoUsers < ActiveRecord::Migration
  def self.up
    add_column :recipes, :user_id, :integer
    add_column :users, :name, :string

    change_table :users do |t|
      t.trackable
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
