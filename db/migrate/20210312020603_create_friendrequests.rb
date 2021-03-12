class CreateFriendrequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friendrequests do |t|
      t.references :requestor, null: false, foreign_key: true
      t.references :pending_friend, null: false, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
