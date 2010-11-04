class CreateUserLogs < ActiveRecord::Migration
  def self.up
    create_table :user_logs do |t|
      t.integer :user_id
      t.datetime :logintime
      t.datetime :logouttime
      t.string :ipaddres

      t.timestamps
    end
  end

  def self.down
    drop_table :user_logs
  end
end
