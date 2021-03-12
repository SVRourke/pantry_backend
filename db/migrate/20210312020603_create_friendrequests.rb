class CreateFriendrequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friendrequests do |t|
      t.references :requestor, null: false
      t.references :pending_friend, null: false
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
