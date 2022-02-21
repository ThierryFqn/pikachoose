class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :day_price
      t.float :height
      t.float :weight
      t.string :gender
      t.string :type
      t.string :personality
      t.text :description

      t.timestamps
    end
  end
end
