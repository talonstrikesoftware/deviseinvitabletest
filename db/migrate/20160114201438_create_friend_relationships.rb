# rails g model FriendRelationship
class CreateFriendRelationships < ActiveRecord::Migration
  def change
    create_table :friend_relationships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps null:false
    end
    add_index :friend_relationships, :user_id
    add_index :friend_relationships, :friend_id
    add_index :friend_relationships, [:user_id, :friend_id], unique: true
  end
end
