class CreateListInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :list_invites do |t|
      t.references :list, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: true
      t.references :pending_contributor, null: false, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
