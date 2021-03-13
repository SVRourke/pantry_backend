class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :jti, null: false

      t.timestamps
    end
    add_index :users, :jti, unique: true
  end
end
