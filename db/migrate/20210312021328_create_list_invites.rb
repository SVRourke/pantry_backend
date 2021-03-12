class CreateListInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :list_invites do |t|
      t.references :list, null: false
      t.references :sender, null: false
      t.references :pending_contributor, null: false
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
