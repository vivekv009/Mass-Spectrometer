class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      # Uncomment below if timestamps were not included in your original model.
      t.timestamps
    end
    
    # add full name to table
    add_column :users, :name, :string
    add_index  :users, :name
    
    # add username to table
    add_column :users, :username, :string
    add_index :users, :username,                :unique => true
    
    # add admin boolean value to table
    add_column :users, :admin, :boolean, :default => false
    add_index  :users, :admin
    
    # add approved account boolean value to table
    add_column :users, :approved, :boolean, :default => false, :null => false
    add_index  :users, :approved
    
    # add enabled account boolean value to table
    add_column :users, :enabled, :boolean, :default => false, :null => false
    add_index  :users, :enabled 
    
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
