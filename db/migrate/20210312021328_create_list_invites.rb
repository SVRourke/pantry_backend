class CreateListInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :list_invites do |t|
      t.references :requestor
      t.references :pending_contributor
      t.references :list
      t.boolean :accepted

      t.timestamps
    end
  end
end
