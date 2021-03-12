class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, null: false
      t.references :list, null: false
      t.string :name
      t.string :amount
      t.boolean :acquired

      t.timestamps
    end
  end
end
