class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.string :name
      t.string :amount
      t.boolean :acquired

      t.timestamps
    end
  end
end
