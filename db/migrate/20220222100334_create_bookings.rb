class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.datetime :begin_date
      t.datetime :end_date
      t.string :status
      t.integer :total_price

      t.timestamps
    end
  end
end
