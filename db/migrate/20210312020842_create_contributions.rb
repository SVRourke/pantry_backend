class CreateContributions < ActiveRecord::Migration[6.1]
  def change
    create_table :contributions do |t|
      t.references :user, null: false
      t.references :list, null: false

      t.timestamps
    end
  end
end
