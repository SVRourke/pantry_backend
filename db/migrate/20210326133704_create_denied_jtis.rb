class CreateDeniedJtis < ActiveRecord::Migration[6.1]
  def change
    create_table :denied_jtis do |t|
      t.string :jti
      t.datetime :expiration

      t.timestamps
    end
  end
end
